# UINavigationBarColorDynamicDemo

早先,有一次在使用iOS版qq的时候,发现个人资料页的navigation bar是透明的,内容往上滚动时,bar会变成不透明,而且个人资料页面在与其他页面切换时,动画比较自然流畅,觉得比较牛逼,就想办法自己实现了一下.

只是个简单demo,代码比较粗糙,仅实现了效果,不要在意太多细节.

需要注意的:

1.因为需要自定义navigation bar的背景色,所以方便起见,就给系统的bar加了个扩展,方便添加方法.详情参见UINavigationBar+BackgroundColor文件.

2.需要在AppDelegate中设置:[[UINavigationBar appearance] setShadowImage:[UIImage new]],去除bar下面的黑线.

3.因为在把bar的背景色设置为透明之后,bar下面是显示黑色(window的背景色),所以需要设置window的背景色与bar默认背景色一致,否则做pop的时候,bar的位置是一片黑色,效果不太好.

4.在从bar不透明的界面push到bar透明的界面时,需要加一个动画效果,否则有点突兀.

5.在获取pop距离的时候,用了一个比较取巧的方法,使用了navigatio controller 的 interactivePopGestureRecognizer ,获取pan移动的距离,然后除以屏幕宽度,得到bar的透明度.(本来以为需要自定义pop动画)

6.qq个人资料页的navigation bar是自定义的,我没猜出来是为了干什么,在这个demo里全部是使用的系统bar.