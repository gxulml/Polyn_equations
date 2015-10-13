function fy = r33func(x,d,vn)
%   �ļ���: r33func.m
%   ��Ȩ: GuangXi Univ.
%   ����: Xz Tang, robo
%   ����: Oct. 12, 2015  
%   ����: ����ϣ��������㶨����ʽ��ߵĶ���ʽ
%    
%   �������˵���� xΪ�߱�������һ����ű���x(i) ( i = 1,...,n )��x(i)�������Ķ���1�е�x_i����x(1)�����һ���� <1,2>
%                 dΪ��߽���
%                 vnΪ������

en = vn * (vn-1) /2;                %�������
e = sym(zeros(vn,vn));              %����߼���Ӧ�Ķ�ά���飬e(i,j)����<i,j>����Ӧ�ı߱�������ʼ��Ϊ0 
k = 1;                              %x��������ʼ���
for i=1:vn                          %��ÿ������ i   
    for j = i+1 : vn                %��ÿ��i���ڵ�j
        e(i,j) = x(k) ;             %������x(k)����e(i,j)
        k = k+1;                    %k����
    end
end
vertex =[];                         %���㼯����ʼ��Ϊ��
for i = 1:vn
    vertex = [vertex,i] ;           %���ɶ��㼯{1,2,3,...,vn}
end

combarr = combntns(vertex,3);        %�Ӷ��㼯vertex����ѡ3�����㣬�����е�ȡֵ���
size_of_combarr = size(combarr,1);   %������ȡֵ��ϵ���������3�ŵ���Ŀ
for i = 1:size_of_combarr            %��ÿһ��3��
    u = combarr(i,1);                %��uΪ��1������
    v = combarr(i,2);                %��vΪ��2������
    w = combarr(i,3);                %��wΪ��3������
    h = e(u,v)+e(u,w)+e(v,w);        %��hΪ3�ŵ�3���ߵĺ�, ������1��S_G(GΪ3��K_3)
    f(i) = (h-1)*(h-2);              %��Ϊs=t=3����˶���2����������̺ϲ����õ�f(i)
end

for i = 1:en
    f(size_of_combarr+i) = x(i)*(x(i)-1) ;               %��Ӧ����2��һ�����̣���f_i
end

cnum = (en + 1)*(vn * (vn - 1) * (vn - 2) / 6 + en)      %����ϵ���ĸ���
c = sym('c',[1,cnum]);                                   %ϵ������
syms fy                                                  %�������ʽ���ű���
fy = 0;

for i = 1:35                                             %6�����㣬15���ߣ�20��3�ţ�����У�20+15=35��������
    k = 16 * (i-1) + 1;                                  %15��������ÿ������ǰһ��ϵ��������һ���������16��
    alpha(i) = c(k);                                     %�������ᵽ��ϣ��������㶨���alpha_i����ʼ��Ϊ������ϵ��
    for j = 1:15
        alpha(i) = alpha(i) + c(k+j) * x(j);             %��һ����c_(k+j) * x_j�����alpha_i = c_k + c_(k+1) * x_1 + c_(k+2) * x_2 + ... + c(k+15) * x_15
    end
    fy = fy + alpha(i) * f(i);                           %��һ���� alpha_i * f_i
end

end

