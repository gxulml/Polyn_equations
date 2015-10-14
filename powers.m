function  powers(n, b, i, powerline)
%   �ļ���: powers.m
%   ��Ȩ: GuangXi Univ.
%   ����: XZ Tang, robo
%   ����: Oct. 12, 2015  
%   ����: �ݹ麯�������ھ���n��Ԫ�ص�����powerline�����õ�i����n��Ԫ�ص�ֵ��ʹ��Щֵ�ĺ�Ϊb,
%         �����ս�powerline����ָ������power_matrix 
%   �������˵���� nΪ������
%                 bΪ�涨�ĵ�i����n��Ԫ�صĺ�
%                 iΪ����Ԫ�ص���ʼ���
%                 powerlineΪ�Ѿ����úõ�1����i-1��Ԫ�ص����飨�ʼΪ�գ���������������i����ߵ�Ԫ��
%                            ���ջ���һ��d�׶���ʽ��ָ�����У�������power_matrix��

global power_matrix    %������������������ָ��������Ʃ��b�ף�����ʽ��ָ��
%��i�ж�Ӧx_i��ָ������n��
%ÿһ�ж�Ӧһ��ָ�������ĵ���ʽ 
%����ĳһ��Ϊ[0,1,2,0,3], ���Ӧ����6�׵���ʽx(2) * x(3)^w * x(5)^3

if (b == 0)                                             %����i����n��Ԫ�صĺ���Ϊ0
    powerline(i:n)=0;                                   %����Щֵ����Ϊ0
    power_matrix = [power_matrix;powerline];            %����power_matrix
else if (i == n)                                        %������ֻ�������һ��Ԫ��
        powerline(n)=b;                                 %���һ��Ԫ��ֵ��Ϊb
        power_matrix = [power_matrix;powerline];        %����power_matrix
    else if (i < n)                                     %���������������
        for j = b :-1: 0                                %ѭ������
            powerline(i)=j;                             %��iλ������Ϊb, b-1, b-2, ..., 0
            powers(n,b-j,i+1,powerline);                %ʣ�µ�Ԫ��ֵ֮��Ϊb-j���ݹ���ñ��������õ�i+1����ʼ�ĺ���Ԫ��
        end
    end  
end

end

