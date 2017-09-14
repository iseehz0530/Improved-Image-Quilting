function [left_feature right_feature top_feature boom_feature] = picHog(img,overlap,alpha)

% 求图像4个边缘的特征信息，梯度+RGB
% overlap = 20;
% img = imread('1.jpg');
% alpha = 0.6;

[height,width,k] = size(img);

left_pic = img(1:height,1:overlap,:);
right_pic = img(1:height,end-overlap+1:end,:);
top_pic = img(1:overlap,1:width,:);
boom_pic = img(end-overlap+1:end,1:width,:);


left_gradient = gradient(double(left_pic));
right_gradient = gradient(double(right_pic));
top_gradient = gradient(double(top_pic));
boom_gradient = gradient(double(boom_pic));


left_rgb_sum = sum(sum(sum(double(left_pic))));
right_rgb_sum = sum(sum(sum(double(right_pic))));
top_rgb_sum = sum(sum(sum(double(top_pic))));
boom_rgb_sum = sum(sum(sum(double(boom_pic))));


left_grad_sum = sum(sum(sum(left_gradient)));
right_grad_sum = sum(sum(sum(right_gradient)));
top_grad_sum = sum(sum(sum(top_gradient)));
boom_grad_sum = sum(sum(sum(boom_gradient)));


% 特征设定为   梯度信息 + RGB信息
left_feature = alpha*left_rgb_sum + (1-alpha)*left_grad_sum;
right_feature = alpha*right_rgb_sum + (1-alpha)*right_grad_sum;
top_feature = alpha*top_rgb_sum + (1-alpha)*top_grad_sum;
boom_feature = alpha*boom_rgb_sum + (1-alpha)*boom_grad_sum;


end