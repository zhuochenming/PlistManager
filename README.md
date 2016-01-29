# PlistManager
init
1.创建plist文件：[PlistManager createPlistWithName:nil];//不填名字默认为info

2.写入

2.1 [PlistManager name:@"小七" password:@"大逗比"];//设置用户名密码

2.2 [PlistManager writeToPlistWithKey:@"小七" value:@"卖萌"];//添加其他文件

3。读取 [PlistManager readDataWithKey:@"小七"]; 

#define Name @"name"
#define PassWord @"password" //用来读取用户名密码
