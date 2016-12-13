/*Author: Clemens Birklbauer*/
#include "mex.h" 
#include <string.h>
#include <math.h>
#include "matrix.h"
void mexFunction(int nlhs, mxArray *plhs[],
    int nrhs, const mxArray *prhs[]) {
  
  /*mxClassID imclassid = mxGetClassID(mexGetVariable("caller","shiftim"));
  const mxArray *im = mexGetVariablePtr("caller","shiftim");
  double* ptr_im = mxGetPr(im);
  unsigned char* ptr_imb = (unsigned char*)ptr_im;*/
  
  mxClassID imclassid = mxGetClassID(prhs[0]);
  const mxArray *im = prhs[0];
  double* ptr_im = mxGetPr(prhs[0]);
  unsigned char* ptr_imb = (unsigned char*)ptr_im;
  
  bool isbytearray = imclassid!=mxDOUBLE_CLASS;
  const double multiply = 1.0/255.0;
  
  mwSize ndimim = mxGetNumberOfDimensions(im);
  const mwSize * size = mxGetDimensions(im);
  
  int imheight = size[0];//mxGetM(im); //image height
  int imwidth = size[1];//mxGetN(im); //is image width multiplied with colorcount(=3)
  //int imwidth = imwidth3/3;
  int ncolors = 1;
  if(ndimim > 2)
      ncolors = size[2];
  
  double shiftx = *mxGetPr(prhs[1]);
  double shifty = *(mxGetPr(prhs[1])+1);
  
  double* ptr_sumim;
  bool sumim = false;
  double weight = 1.0;
  if(nrhs > 2)
  {
      ptr_sumim = mxGetPr(mexGetVariablePtr("caller","sumim"));
      sumim = true;
      weight = *mxGetPr(prhs[2]);
  }
  
  double *output;
  
  int ndim = 3;
  int dims[3] = {imheight, imwidth, ncolors};
  
  //mexPrintf("%f %f\n",shiftx,floor(-1.3));
  //mexPrintf("%d %d\n",imheight,imwidth3);
  //mexPrintf("%d %d %d\n",dims[0],dims[1],dims[2]);

  plhs[0] = mxCreateNumericArray(ndim, dims, mxDOUBLE_CLASS ,mxREAL);
  
  //plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
  output = mxGetPr(plhs[0]);
  
  //mexPrintf("%d %d %d %d\n",orgx,orgy,x,y);
  /*if (ptr_trP==NULL) mexErrMsgTxt("Variable 'trP' not in workspace.");
  if (ptr_im==NULL) mexErrMsgTxt("Variable 'im' not in workspace.");
  if (ptr_seamimage==NULL) mexErrMsgTxt("Variable 'seamimage' not in workspace.");*/
  
  //shiftx = -shiftx;
  //shifty = -shifty;
  double ax = 1-(shiftx - floor(shiftx));
  double ay = 1-(shifty - floor(shifty));
  
  //#pragma omp parallel for
  for(int color = 0; color < ncolors; color++)
  {
    #pragma omp parallel for  
    for(int py = 0; py < imwidth; py++)
    {
        //mexPrintf("%d %d\n",px,py);
        //off = 0;
        //#pragma omp parallel for  
        for (int px=0; px < imheight; px++)
        {
            int ox,oy,ox1,oy1;
            ox = ((double)px)-floor(shiftx);
            oy = ((double)py)-floor(shifty);
            
            ox1 = ((double)px)-(floor(shiftx)+1);
            if(ox1 >= imheight) ox1--;
            if(ox1 < 0) ox1=0;
            oy1 = ((double)py)-(floor(shifty)+1);
            if(oy1 >= imwidth) oy1--;
            if(oy1 < 0) oy1=0;
            
            /*if(shiftx<0)
            {
                int tmp = ox1;
                ox1 = ox;
                ox = tmp;
            }
            if(shifty<0)
            {
                int tmp = oy1;
                oy1 = oy;
                oy = tmp;
            }*/
            
            if ((ox >= 0) && (ox < imheight) && (oy >= 0) && (oy < imwidth))
            {
                //mexPrintf("ox %d %d\n",ox,oy);
                if(sumim)
                {
                    if(isbytearray)
                        ptr_sumim[px+py*imheight+color*(imwidth*imheight)] += weight*multiply*(ptr_imb[ox+oy*imheight+color*(imwidth*imheight)]*ax*ay + 
                                                                      ptr_imb[ox1+oy*imheight+color*(imwidth*imheight)]*(1.0-ax)*(ay) +
                                                                      ptr_imb[ox+oy1*imheight+color*(imwidth*imheight)]*(ax)*(1.0-ay) +
                                                                      ptr_imb[ox1+oy1*imheight+color*(imwidth*imheight)]*(1.0-ax)*(1.0-ay));
                    else
                        ptr_sumim[px+py*imheight+color*(imwidth*imheight)] += weight*(ptr_im[ox+oy*imheight+color*(imwidth*imheight)]*ax*ay + 
                                                                      ptr_im[ox1+oy*imheight+color*(imwidth*imheight)]*(1.0-ax)*(ay) +
                                                                      ptr_im[ox+oy1*imheight+color*(imwidth*imheight)]*(ax)*(1.0-ay) +
                                                                      ptr_im[ox1+oy1*imheight+color*(imwidth*imheight)]*(1.0-ax)*(1.0-ay));
                }
                else
                {
                    if(isbytearray)
                        output[px+py*imheight+color*(imwidth*imheight)] = multiply*(ptr_imb[ox+oy*imheight+color*(imwidth*imheight)]*(ax*ay) + 
                                                                      ptr_imb[ox1+oy*imheight+color*(imwidth*imheight)]*((1.0-ax)*ay) +
                                                                      ptr_imb[ox+oy1*imheight+color*(imwidth*imheight)]*(ax*(1.0-ay)) +
                                                                      ptr_imb[ox1+oy1*imheight+color*(imwidth*imheight)]*((1.0-ax)*(1.0-ay)));
                    else
                        output[px+py*imheight+color*(imwidth*imheight)] = ptr_im[ox+oy*imheight+color*(imwidth*imheight)]*ax*ay + 
                                                                      ptr_im[ox1+oy*imheight+color*(imwidth*imheight)]*(1.0-ax)*ay +
                                                                      ptr_im[ox+oy1*imheight+color*(imwidth*imheight)]*ax*(1.0-ay) +
                                                                      ptr_im[ox1+oy1*imheight+color*(imwidth*imheight)]*(1.0-ax)*(1.0-ay);
                }
            }
        }
    }
  }
} 