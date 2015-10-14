function  powers(n, b, i, powerline)
%   文件名: powers.m
%   版权: GuangXi Univ.
%   作者: XZ Tang, robo
%   日期: Oct. 12, 2015  
%   描述: 递归函数，对于具有n个元素的数组powerline，设置第i到第n个元素的值，使这些值的和为b,
%         并最终将powerline存入指数矩阵power_matrix 
%   输入变量说明： n为变量数
%                 b为规定的第i到第n个元素的和
%                 i为设置元素的起始序号
%                 powerline为已经设置好第1到第i-1个元素的数组（最开始为空），本函数将设置i及后边的元素
%                            最终会是一个d阶多项式的指数序列，并存入power_matrix中

global power_matrix    %公共变量，保存所有指定阶数（譬如b阶）单项式的指数
%第i列对应x_i的指数，共n列
%每一行对应一个指定阶数的单项式 
%例：某一行为[0,1,2,0,3], 则对应的是6阶单项式x(2) * x(3)^w * x(5)^3

if (b == 0)                                             %若第i到第n个元素的和须为0
    powerline(i:n)=0;                                   %则这些值都设为0
    power_matrix = [power_matrix;powerline];            %存入power_matrix
else if (i == n)                                        %否则，若只须设最后一个元素
        powerline(n)=b;                                 %最后一个元素值设为b
        power_matrix = [power_matrix;powerline];        %存入power_matrix
    else if (i < n)                                     %不属于上述情况的
        for j = b :-1: 0                                %循环处理
            powerline(i)=j;                             %第i位依次设为b, b-1, b-2, ..., 0
            powers(n,b-j,i+1,powerline);                %剩下的元素值之和为b-j，递归调用本函数设置第i+1个开始的后续元素
        end
    end  
end

end

