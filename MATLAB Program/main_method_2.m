im_file = 'demo.jpg';
RGB = imread(im_file);
imwrite([RGB(:,:,:) fliplr(RGB(:,:,:))],'test.jpg');%����˫���Գ�ͼ�񲢱���
image='test.jpg';
map = region_m2(image);%��˫���Գ�ͼ�����CM���
[m,n,channel]=size(RGB);
map=map(:,1:n)+fliplr(map(:,size(map,2)-n+1:size(map,2)));%���������ת�ϲ�
map=(map>0);
imshow(map);