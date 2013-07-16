#include<cstdio>
#include<iostream>
#include<opencv2/core/core.hpp>
#include"opencv2/features2d/features2d.hpp"
#include"opencv2/highgui/highgui.hpp"
#include"opencv2/calib3d/calib3d.hpp"
#include"opencv2/nonfree/features2d.hpp"
#include"kaze_features.h"

using namespace cv;
void readme();

int main(){
    Mat img_1=imread("1.png",CV_LOAD_IMAGE_GRAYSCALE);
    Mat img_2=imread("2.png",CV_LOAD_IMAGE_GRAYSCALE);
    if(!img_1.data||!img_2.data)printf("error");

    toptions opt;
    KAZE k(opt);
    std::vector<KeyPoint> k1,k2;
    Mat dr1,dr2;
    k(img_1,k1,dr1);
    k(img_2,k2,dr2);

    BFMatcher mtr;
    std::vector<DMatch> mts;
    mtr.match(dr1,dr2,mts);

    double maxd=0,mind=100;

    for(int i=0;i<dr1.rows;++i){
        double dst=mts[i].distance;
        if(dst<mind)mind=dst;
        if(dst>maxd)maxd=dst;
    }
    printf("%f,%f",maxd,mind);

    std::vector<DMatch>gmts;

    for(int i=0;i<dr1.rows;++i){
        if(mts[i].distance<2.1*mind){
            gmts.push_back(mts[i]);
        }
    }

    Mat ik1;
    drawMatches(img_1,k1,img_2,k2,gmts,ik1,Scalar::all(-1),Scalar::all(-1),vector<char>(),DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS);

    std::vector<Point2f> obj,scene;
    for(int i=0;i<gmts.size();++i){
        obj.push_back(k1[gmts[i].queryIdx].pt);
        scene.push_back(k2[gmts[i].trainIdx].pt);
    }
    Mat H=findHomography(obj,scene,CV_RANSAC);

    std::vector<Point2f> obj_corners(4);
    obj_corners[0]=cvPoint(0,0);
    obj_corners[1]=cvPoint(img_1.cols,0);
    obj_corners[2]=cvPoint(img_1.cols,img_1.rows);
    obj_corners[3]=cvPoint(0,img_1.rows);
    std::vector<Point2f> scene_corners(4);

    perspectiveTransform(obj_corners,scene_corners,H);

    Point2f org=Point2f(img_1.cols,0);
    line(ik1,scene_corners[0]+org,scene_corners[1]+org,Scalar(0,255,0),4);
    line(ik1,scene_corners[1]+org,scene_corners[2]+org,Scalar(0,255,0),4);
    line(ik1,scene_corners[2]+org,scene_corners[3]+org,Scalar(0,255,0),4);
    line(ik1,scene_corners[3]+org,scene_corners[0]+org,Scalar(0,255,0),4);
    imshow("Keypoints 1",ik1);

    Mat mask=imread("1mask.png",CV_LOAD_IMAGE_GRAYSCALE),maskp=Mat::zeros(img_2.size(),img_2.type());
    Mat masked=Mat::zeros(img_2.size(),img_2.type());
    warpPerspective(mask, maskp, H,maskp.size());
    img_2.copyTo(masked,maskp);
    imshow("d",masked);
    waitKey(0);
    return 0;
}
