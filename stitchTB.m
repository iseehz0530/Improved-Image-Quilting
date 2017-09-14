function result = stitchTB(toptile,boomtile,overlap,tilesize)

% 上下缝合
top = toptile(end - overlap+1:end,1:tilesize,1:3);
boom = boomtile(1:overlap,1:tilesize,1:3);

%             转灰度图，便于计算
toptile_gray=im2double(rgb2gray(toptile));
boomtile_gray = im2double(rgb2gray(boomtile));

top_gray = toptile_gray(end - overlap+1:end,1:tilesize);
boom_gray = boomtile_gray(1:overlap,1:tilesize);

cost = abs(top_gray - boom_gray);
path = shortest_path(cost');

h = size(top, 2);
%Transform the path into an alpha mask for each image
image_1_alpha_stitch = ones(h,overlap);
for i = 1:h
    image_1_alpha_stitch(i, path(i)+1:end) = 0;
end
% 转置一下
image_1_alpha_stitch = image_1_alpha_stitch';
image_2_alpha_stitch = 1 - image_1_alpha_stitch;

image_1_alpha_stitch = repmat(image_1_alpha_stitch,[1 1 3]);
image_2_alpha_stitch = repmat(image_2_alpha_stitch,[1 1 3]);

%Compute strip with the standard equation for compositing
topOutput = toptile(1:end-overlap, 1:tilesize,1:3);
boomOutput = boomtile(overlap+1:end, 1:tilesize,1:3);

strip = uint8(image_1_alpha_stitch).*top + uint8(image_2_alpha_stitch).*boom;

result = cat(1,topOutput,strip,boomOutput);

end



