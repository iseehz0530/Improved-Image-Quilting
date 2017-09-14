function result = stitchLR(lefttile,rightTile,overlap,tilesize)
% 左右缝合
% 用灰度值去判断误差

left = lefttile(1:tilesize,end - overlap+1:end,1:3);
right = rightTile(1:tilesize,1:overlap,1:3);

cost = abs(left - right);

path = shortest_path(cost);

%Compute strip with the standard equation for compositing
% 从原图像切割，无需处理
leftOutput = lefttile(:, 1:end-overlap,1:3);
rightOutput = rightTile(:, overlap+1:end,1:3);

h = size(lefttile, 1);
%Transform the path into an alpha mask for each image
image_1_alpha_stitch = ones(h,overlap);

for i = 1:h
    image_1_alpha_stitch(i, path(i)+1:end) = 0;
end

image_2_alpha_stitch = 1 - image_1_alpha_stitch(:,:);

image_1_alpha_stitch = repmat(image_1_alpha_stitch,[1 1 3]);
image_2_alpha_stitch = repmat(image_2_alpha_stitch,[1 1 3]);

strip = uint8(image_1_alpha_stitch).*left + uint8(image_2_alpha_stitch).*right;

result = [leftOutput strip rightOutput];

end