function [im,match_r,loc] = remove_m2(image)
[im,num,match,loc] = newmatch(image);
k=400;
l=2;
i=1;
while i<num  %ȥ���ӽ�ƥ��ԣ��ظ�ƥ���
    if (loc(match(i,1),1)-loc(match(i,2),1))^2+(loc(match(i,1),2)-loc(match(i,2),2))^2<10
        match(i,:)=[];
        num=num-1;
        continue;
    end
    j=i+1;
    while j<num+1
        if((loc(match(i,1),1)==loc(match(j,1),1))&&(loc(match(i,1),2)==loc(match(j,1),2)) ...
            &&(loc(match(i,2),1)==loc(match(j,2),1))&&(loc(match(i,2),2)==loc(match(j,2),2)))
            match(j,:)=[];
            num=num-1;
            j=j-1;
        end
        j=j+1;
    end
    i=i+1;
end
i=1;
while i<num+1
    if(match(i,2)==0)
        match(i,:)=[];
    else
        i=i+1;
    end
end %���е�ƥ���
match=match(1:num,:);
r=[];

for i=1:num
    count=0;
    if i==1
        r1=match(i,:);
        for j=2:num
            d1=(loc(match(i,1),1)-loc(match(j,1),1))^2+(loc(match(i,1),2)-loc(match(j,1),2))^2;%
            d2=(loc(match(i,2),1)-loc(match(j,2),1))^2+(loc(match(i,2),2)-loc(match(j,2),2))^2;%
            d3=(loc(match(i,1),1)-loc(match(j,2),1))^2+(loc(match(i,1),2)-loc(match(j,2),2))^2;%
            d4=(loc(match(i,2),1)-loc(match(j,1),1))^2+(loc(match(i,2),2)-loc(match(j,1),2))^2;%
            if ((d1<k)&&(d2<k)) ||((d3<k)&&(d4<k)) 
                count=count+1;
                r1=[r1 match(j,:)];
            end
        end
        if count<l
            r=[r;i];
        end
    else      
    r2=[];
    r2=match(i,:);
    for j=[1:i-1 i+1:num]
        d1=(loc(match(i,1),1)-loc(match(j,1),1))^2+(loc(match(i,1),2)-loc(match(j,1),2))^2;%
        d2=(loc(match(i,2),1)-loc(match(j,2),1))^2+(loc(match(i,2),2)-loc(match(j,2),2))^2;%
        d3=(loc(match(i,1),1)-loc(match(j,2),1))^2+(loc(match(i,1),2)-loc(match(j,2),2))^2;%
        d4=(loc(match(i,2),1)-loc(match(j,1),1))^2+(loc(match(i,2),2)-loc(match(j,1),2))^2;%
        if ((d1<k)&&(d2<k)) ||((d3<k)&&(d4<k)) 
            count=count+1;
            r2=[r2; match(j,:)];
        end
    end
    if count<l
        r=[r;i];
    end
    end
end
match_r=match;
match_r(r,:)=[];  
%% ��ʾ��Χ��ƥ���
% figure
% colormap('gray');
% imagesc(im);
% hold on;
% title(['��Χ' int2str(sqrt(k)) '���ط�Χ������' int2str(l) '��ƥ���'])
% for i = 1: size(match_r,1)
%     line([loc(match_r(i,1),2) loc(match_r(i,2),2)], ...
%          [loc(match_r(i,1),1) loc(match_r(i,2),1)], 'Color', 'c');
%  end

end