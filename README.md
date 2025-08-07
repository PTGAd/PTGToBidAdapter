#ToBid平台，Fancy广告适配器

## 导入 SDK
使用CocoaPods导入SDK

```shell
  pod 'ToBid-iOS','~> 4.5.30'
  pod 'PTGAdFramework', '2.2.81'
  pod 'PTGToBidAdapter','2.2.80.0'
```
## 使用Tobid适配器的媒体请注意
在广告展示前，需调用Tobid广告是否有效，只有当isAdReady (banner广告是 isAdValid）为YES时，才展示广告。否则会造成广告展示失败，可能会造成线上展示数据存在差异从而引起媒体收益数据差异。

## 适配器相关
需要在ToBid后台添加自定义广告平台

### 初始化适配器
PTGToBidConfigAdapter
需要在添加自定义广告源时，需要添加应用维度参数app_id,app_key参数（fancy广告平台的app_id,app_key)
   
### 开屏
PTGToBidSplashAdapter  

### 信息流
PTGToBidNativeAdapter  
支持模板及自渲染信息流 默认模板，如需支持自渲染需在添加广告源代码位界面时，自定义配置信息中填写 {"self_render": "1"}

### banner
PTGToBidBannerAdapter  

### 插屏
PTGToBidInterstitialAdapter  
插屏默认点击广告后不关闭，如果需要点击后关闭插屏，可以在tobid自定义配置中填写 {"closeAfterClick":"1"}

### 激励
PTGToBidRewardedVideoAdapter  
