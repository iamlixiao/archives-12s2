#include "opencv2/opencv_modules.hpp"
#include "opencv2/core/core.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/gpu/gpu.hpp"
#include "opencv2/nonfree/gpu.hpp"
#include <ctime>
#include <sys/time.h>
#include <iostream>
using namespace cv;
using namespace cv::gpu;
int main(){
	GpuMat img1, img2(imread("../2.png",IMREAD_GRAYSCALE));
	Mat rst=imread("../1.png",IMREAD_GRAYSCALE);
	img1.upload(rst);
	
	SURF_GPU surf;
	GpuMat keypoints1GPU, keypoints2GPU;
	GpuMat descriptors1GPU, descriptors2GPU;
	surf(img1, GpuMat(), keypoints1GPU, descriptors1GPU);
	
	timeval start,finish;
	gettimeofday(&start,NULL);
	surf(img2, GpuMat(), keypoints2GPU, descriptors2GPU);
	gettimeofday(&finish,NULL);
	std::cout<<(1000000*(finish.tv_sec - start.tv_sec) + finish.tv_usec - start.tv_usec)<<std::endl;
	
	BFMatcher_GPU matcher(NORM_L2);
	GpuMat trainIdx, distance;
	gettimeofday(&start,NULL);
	matcher.matchSingle(descriptors1GPU, descriptors2GPU, trainIdx, distance);
	gettimeofday(&finish,NULL);
	std::cout<<(1000000*(finish.tv_sec - start.tv_sec) + finish.tv_usec - start.tv_usec)<<std::endl;
	
	vector<KeyPoint> keypoints1, keypoints2;
    vector<float> descriptors1, descriptors2;
    vector<DMatch> matches;
	gettimeofday(&start,NULL);
    surf.downloadKeypoints(keypoints1GPU, keypoints1);
    surf.downloadKeypoints(keypoints2GPU, keypoints2);
    surf.downloadDescriptors(descriptors1GPU, descriptors1);
    surf.downloadDescriptors(descriptors2GPU, descriptors2);
    BFMatcher_GPU::matchDownload(trainIdx, distance, matches);
	gettimeofday(&finish,NULL);
	std::cout<<(1000000*(finish.tv_sec - start.tv_sec) + finish.tv_usec - start.tv_usec)<<std::endl;

    // drawing the results
    Mat img_matches;
    drawMatches(Mat(img1), keypoints1, Mat(img2), keypoints2, matches, img_matches);

	imshow("hh",img_matches);
	waitKey(0);
}
