function err = err_grad_rgb(lefttile,rightTile,overlap,tilesize)

% 左右缝合
% 用灰度值去判断误差

left = lefttile(1:tilesize,end - overlap+1:end,1:3);
right = rightTile(1:tilesize,1:overlap,1:3);

left_gradient = gradient(double(left));
right_gradient = gradient(double(right));

rgb_cost = abs(left - right);
grad_cost = abs(left_gradient - right_gradient);

err_rgb_sum = sum(sum(sum(rgb_cost)));
err_grad_sum = sum(sum(sum(grad_cost)));
err = 0.6*err_rgb_sum + 0.4*err_grad_sum;

end