# HormosWanAndroid
a Hormos Project use Wan Android Api

1. 鸿蒙使用Hvigor工具链对应用进行打包构建，产物位于各自模块下的build[文件夹](https://so.csdn.net/so/search?q=文件夹&spm=1001.2101.3001.7020)中。

2. 打包后的产物包括一个.app文件和多个.hap文件。

   - hap是可以直接运行在模拟器或真机设备中的软件包。

   - app则是用于应用/服务上架到华为应用市场。

3. 任务流的执行是通过构建插件hvigor-ohos-plugin利用Hvigor的任务编排机制实现的。

##### 1. 构建工具和构建插件版本（./hvigor/hvigor-config.json5）

```json
{
  "hvigorVersion": "2.4.2",
  "dependencies": {
    "@ohos/hvigor-ohos-plugin": "2.4.2" //插件版本
  }
}
```

##### 2. 构建配置文件/编译构建参数（工程或module/build-profile.json5）

```json
// 工程目录
{
  "app": {
    // 工程的签名信息，可包含多个签名信息  
    "signingConfigs": [
        {
        // 标识签名方案的名称
        "name": "default",  
        // 标识HarmonyOS应用
        "type": "HarmonyOS",  
        // 该方案的签名材料
        "material": {  
          // 调试或发布证书文件，格式为.cer
          "certpath": "D:\\SigningConfig\\debug_hos.cer",  
          // 密钥库密码，以密文形式呈现
          "storePassword": "******",
          // 密钥别名信息
          "keyAlias": "debugKey",  
          // 密钥密码，以密文形式呈现
          "keyPassword": "******",  
          // 调试或发布证书Profile文件，格式为.p7b
          "profile": "D:\\SigningConfig\\debug_hos.p7b",  
          // 密钥库signAlg参数
          "signAlg": "SHA256withECDSA",  
          // 密钥库文件，格式为.p12
          "storeFile": "D:\\SigningConfig\\debug_hos.p12" 
        }
    ],
    // 指定HarmonyOS应用/服务编译时的SDK版本        
    "compileSdkVersion": 9,
    // 指定HarmonyOS应用/服务兼容的最低SDK版本        
    "compatibleSdkVersion": 9,
    // 定义构建的产品品类，如通用默认版、付费版、免费版等        
    "products": [
      {
        // 定义产品的名称，支持定制多product目标产物    
        "name": "default",
        // 指定当前产品品类对应的签名信息，签名信息需要在signingConfigs中进行定义    
        "signingConfig": "default",
      }
    ]
  },
  "modules": [
    {
      // 模块名称  
      "name": "entry",
      // 模块根目录相对工程根目录的相对路径  
      "srcPath": "./entry",
      // 定义构建的APP产物，由product和各模块定义的targets共同定义  
      "targets": [
        {
          // target名称，由各个模块的build-profile.json5中的targets字段定义  
          "name": "default",
          "applyToProducts": [
            // 表示将该模块下的'default' Target打包到'default' Product中  
            "default"
          ]
        }
      ]
    }
  ]
}
```

```json
// module目录
{
  // API类型，支持FA和Stage模型  
  "apiType": 'stageMode',
  "buildOption": {
     // 配置筛选har依赖.so资源文件的过滤规则
     "napiLibFilterOption": {
      	// 按照.so文件的优先级顺序，打包最高优先级的.so文件
      	"pickFirsts": [
        	"**/1.so"
      	],
      	// 按照.so文件的优先级顺序，打包最低优先级的.so 文件
      	"pickLasts": [
        	"**/2.so"
      	],
      	// 排除的.so文件
      	"excludes": [
        	"**/3.so"
      	],
      	// 允许当.so重名冲突时，使用高优先级的.so文件覆盖低优先级的.so文件
      	"enableOverride": true
    },
    // cpp相关编译配置
    "externalNativeOptions": {
      // CMake配置文件，提供CMake构建脚本
      "path": "./src/main/cpp/CMakeLists.txt",  
      // 传递给CMake的可选编译参数
      "arguments": "", 
      // 用于设置本机的ABI编译环境
      "abiFilters": [  
        "armeabi-v7a",
        "arm64-v8a"
      ],
      // 设置C++编译器的可选参数
      "cppFlags": ""  
    }, 
  },
  // 定义的Target，开发者可以定制不同的Target  
  "targets": [
    {
      "name": "default",
      "runtimeOS": "HarmonyOS"
    },
    {
      "name": "ohosTest",
    }
  ]
}
```

##### 3. 编译构建脚本文件（工程或module/hvigorfile.ts）

```json
// 工程文件
// Script for compiling build behavior. It is built in the build plug-in and cannot be modified currently.
export { appTasks } from '@ohos/hvigor-ohos-plugin';
```

```json
// module文件
// Script for compiling build behavior. It is built in the build plug-in and cannot be modified currently.
export { hapTasks } from '@ohos/hvigor-ohos-plugin';
```

##### 4. 依赖配置文件(工程或module/oh-package.json5)

> 通过ohpm来安装、共享、分发代码，管理项目的依赖关系。oh-package.json5格式遵循标准的ohpm规范。

```json
// 工程文件
{
  "name": "hormoswanandroid",
  "version": "1.0.0",
  "description": "Please describe the basic information.",
  "main": "",
  "author": "",
  "license": "",
  "dependencies": { // 依赖库
    "@ohos/pulltorefresh": "2.0.1", //ohpm三方共享包
    "eslint": "^7.32.0",            //ohpm原生三方包
    "library": "file:../library",   //ohpm本地共享包  
  },
  "devDependencies": {
    "@ohos/hypium": "1.0.6"
  },
  "dynamicDependencies": {}
}
```

```json
// module文件
{
  "name": "entry",
  "version": "1.0.0",
  "description": "Please describe the basic information.",
  "main": "",
  "author": "",
  "license": "",
  "dependencies": {}
}
```

##### 5. 依赖安装和同步

两种方式：

1. Terminal窗口执行ohpm install命令。
2. 单击编辑器窗口上方的 Sync Now 进行同步。

> 依赖包会存储在工程或各模块的oh_modules目录下。



##### 6. 启动构建

两种方式：

1. 通过DevEco Studio的 Build 菜单栏的编译选项进行构建，**HAP的构建结果存放于各模块的“build”文件夹下，APP包的构建结果存放于工程的“build”文件夹下**
2. 点击三角形启动按钮。

> Build Hap: 将工程中所有Module构建为HAP。
>
> Build App:将工程构建为APP,APP包含多个HAP。
>
> Make Module: 只会构建当前Module的HAP。

> 1.HAP是 应用安装的基本单位，在DevEco Studio工程目录中，一个HAP对应一个Module。应用打包时，每个Module生成一个.hap文件
> 2.应用如果包含多个Module，在应用市场上架时，会将多个.hap文件打包成一个.app文件（称为Bundle），但 在云端分发和端侧安装时，仍然是以HAP为基本单位
> 3.为了能够正常分发和安装应用，需要 保证一个应用安装到设备时，Module的名称、Ability的名称不重复，并且只有一个Entry类型的Module与目标设备相对应
> 来源：https://blog.csdn.net/HarmonyOS_001/article/details/140070061



##### 7. 关于检验

- **Module校验逻辑**：name不同即可，如果相同就校验deviceType。deviceType如果也相同，就校验分发规则distroFilter。
- **Ability校验规则**：还是先看name,name如果相同，就看所属module的deviceType和distroFilter。

