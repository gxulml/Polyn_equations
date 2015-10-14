function AA = coefmatrix(vn,d)
%   �ļ���: coefmatrix.m
%   ��Ȩ: GuangXi Univ.
%   ����: Xz Tang, robo
%   ����: Oct. 12, 2015  
%   ����: ��ϣ��������㶨���֤�飨ֻ���ϵ��������ѣ�
%   �������˵���� vnΪ������
%                 dΪ��߽���  

a = vn * (vn-1) /2;                 %�������a, aͬʱҲ�Ǳ�����
x_id_range = [1,a];                 %x�����±�ı仯��Χ 
x = sym('x',x_id_range);            %����߱���x������һ����ű���x(i) ( i = 1,...,a )
n = (a + 1)*(vn * (vn - 1) * (vn - 2) / 6 + a)      %����ϵ���ĸ���
c_id_range = [1,n];                 %x�����±�ı仯��Χ 
c = sym('c',c_id_range);            %����߱���c������һ����ű���c(i) ( i = 1,...,n )

syms f                              %������ű���
f = r33func(x,d,vn);                 %��fΪR(3,3)��Ӧ��ϣ��������㶨����ʽ�����
g = expand(f)                       %չ��

%�±ߵĴ����������ʽ��ϵ����
g1 = subs(g,x,zeros(1,a));          %������
gA(1)=g1                            %�浽�����У���Ϊ��һ��

for i=1:a
    gA(i+1)=coef_one(g, g1, x,a,i,d);   %ѭ����x(1), x(2), ..., x(a)��ϵ��������cΪ�����Ķ���ʽ��
end

global power_matrix                 %���幫����������ָ������ʱҪ��
power_matrix = [];                  %��ʼ��Ϊ��
powerline = zeros(1,a);             %����һ��ȫΪ0�ģ�����a��Ԫ�ص�����
powers(a, d, 1, powerline)          %�����Ϊd�����е���ʽ��ָ���ľ���
size(power_matrix,1)
for i = 1: size(power_matrix,1)     %��ÿһ��d�׵���ʽ
    gA(i+a+1)= coef_high(g, g1, x,a,power_matrix(i,:));  %����ϵ������һ����cΪ�����Ķ���ʽ��     
end
A = gA.';                           %��ת��
A(all(A==0,2),:)=[]                 %ɾ��ֵΪ0���� 

shift_col = eye(1,n);               %��ʼ��Ϊ[1,0,0,..., ]

for i=1:n                               %ѭ��
    t(:,i) = subs(A,c,shift_col);       %���滻�б�c����A�еĶ���ʽ�ĵ���ʽ�������滻��shift_col 
    shift_col = circshift(shift_col,[0,1]) ;  %����
end

AA = double(t)                          %��t��ɾ�����ʽ
B = eye(size(AA,1),1);                  %��һ��Ԫ��Ϊ1������Ϊ0 
C = AA\B                                %��ϵ������

end

