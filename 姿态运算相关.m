%%四元数相关的运算

%------------四元数 数学运算-----------
        %  四元数的声明定义 
        quat = quaternion();
        quat = quaternion(A,B,C,D) 
        
        % 求模
        norm(quat)
        % 模归一化处理
        pnormed = normalize(quat)
        % 共轭
        conj(quat)               
        % 提取变量数值
        [a,b,c,d] = parts(quat)
        
%------------四元数 姿态运算-----------------
        % 由欧拉角转到 四元数  这个定义代表了 定坐标系n 向动坐标系b 的转动 
        % n系为 北东地  b系为 前右下
        % 转动顺序为 Z Y X   航向 俯仰 横滚    
        % 对四元数从欧拉角的定义有两种模式，一种是 点的转动，一种是参考框架的转动，
        %      这里我们选择 frame 转动
            quat = quaternion(E,'euler','ZYX','frame')        %切记 切记  这里的E 存储的欧拉角顺序也一定要是 Z Y X 
            quat = quaternion(E,'eulerd','ZYX','frame')        
        
        % 利用四元数进行矢量变换
        %   代表 将定坐标系n系下的矢量 转换到 动坐标系b系下        
            Vb = rotateframe(quat, Vn)
        %   如果 导航解算中，知道 Vb，求Vn 使用：
            Vn = rotateframe(conj(quat),Vb)
            
        % 旋转矢量 到 四元数   这里的旋转矢量对应于 定坐标系n系 到 动坐标b系的 转动 
        %   旋转矢量[X Y Z] 在小角度情况下，不区分 欧拉角的不可交换性误差
            rotationVector = [0.3491,0.6283,0.3491];
            quat = quaternion(rotationVector,'rotvec')  
            quat = quaternion(rotationVector,'rotvecd') 

        % 旋转矩阵 到 四元数  这里注意，旋转矩阵一定是 定坐标系n 到 动坐标系b 的转动矩阵
            quat = quaternion(Cbn,'rotmat','frame')
            
         % 四元数 到 旋转矩阵
            %  n系 矢量 转到 b系 的旋转矩阵 Cbn 为 
            Cbn = rotmat(q, 'frame')
            % 如果要求 b系 矢量 到 n系的投影，可以有：
            Cnb = Cbn';
            Cnb = rotmat(conj(q),'frame')           
            
        % 四元数 到 欧拉角  注意 得到的顺序
            tmpeuler = euler(q, 'ZYX', 'frame')
            tmpeulerd = eulerd(q, 'ZYX', 'frame')

        % 四元数 到 旋转矢量
            rotationVector = rotvec(quat)

            

%------------四元数 更新-----------------
        % 四元数的更新顺序和有的文献不一样，比如两次旋转 1 和 2 
            q_new = q1*q2;
            Cbn_new = Cbn_2*Cbn_1;



%% 加计求水平姿态
        % 在不考虑航向角 或者说，不考虑磁强计时，可以假设磁强计为[1;0;0]
        % 使用的坐标系为 NED
        Magnetic = [1,0,0]; 
        Acc = -IMU(i,2:4)';   % 在NED的情况下，需要对f取负号
        q = ecompass(postAcc,magnetic);
       att = eulerd(q, 'ZYX', 'frame');        











        