import 'package:flutter/material.dart'; //导入material UI 组件包

// 应用入口--作用是启动flutter 应用，runApp它接受一个Widget参数，MyApp()是Flutter应用的根组件
void main() => runApp(MyApp());

// 应用结构
class MyApp extends StatelessWidget {
  // This widget is the root of your application.widget的主要工作是提供一个build()方法来描述如何构建UI界面（通常是通过组合、拼装其它基础widget）
  @override
  Widget build(BuildContext context) {
    // MaterialApp 是Material库中提供的Flutter APP框架
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      // 该属性决定应用的初始路由页是哪一个命名路由
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      // 主题
      theme: ThemeData(
        // 蓝色主题
        primarySwatch: Colors.blue,
      ),
      // 注册路由
      routes: {
        "new_page": (context) => EchoRoute(),
        // "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
        "/": (context) => TapboxA(), //注册首页路由
        "tip2": (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        }
      },
      // 应用首页路由
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // 路由权限配置 onGenerateRoute只会对命名路由生效。
      // onGenerateRoute:(RouteSettings settings){
      //   return MaterialPageRoute(builder:(context){
      //     String routeName=settings.name;
      //     // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
      //     // 引导用户登录；其它情况则正常打开路由。
      //     print('权限界面: $routeName');
      //   };
      // },
    );
  }
}

// 首页--它继承自StatefulWidget类，表示它是一个有状态的组件（Stateful widget）
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  // _MyHomePageState类是MyHomePage类对应的状态类
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// state类
class _MyHomePageState extends State<MyHomePage> {
  // 该组件的状态
  int _counter = 0; //记录点击事件的次数

  // 初始化状态，只会调用一次
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  // 设置状态的自增函数
  void _incrementCounter() {
    // setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面
    setState(() {
      _counter++;
    });
  }

  //构建UI界面 ，Flutter框架会调用Widget的build方法来构建widget树
  @override
  Widget build(BuildContext context) {
    // context参数，它是BuildContext类的一个实例，表示当前widget在widget树中的上下文
    // Scaffold 是 Material 库中提供的页面脚手架，它提供了默认的导航栏、标题和包含主屏幕widget树（后同“组件树”或“部件树”）的body属性
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title)),
      body: Center(
        // body的组件树中包含了一个Center 组件，Center 可以将其子组件树对齐到屏幕中心。
        // Center 子组件是一个Column 组件，Column的作用是将其所有子组件沿屏幕垂直方向依次排列；
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text('$_counter', style: Theme.of(context).textTheme.display1),
              FlatButton(
                  child: Text('open new router'),
                  textColor: Colors.blue,
                  onPressed: () {
                    // 导航到新的路径
                    // 通过路由名打开新路由页
                    Navigator.of(context).pushNamed("tip2", arguments: "hi");
                  })
            ]),
      ),
      // floatingActionButton是页面右下角的带“+”的悬浮按钮，它的onPressed属性接受一个回调函数，代表它被点击后的处理器，
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons
              .add)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // 在widget重新构建时,是否更新
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidet');
  }

  // 当State对象从树中被移除时，或者结点位置发生移动时
  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  // 当State对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  // 在热重载(hot reload)时会被调用
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  // 当State对象的依赖发生变化时会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

// 路由管理模块
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Route')),
      body: Center(child: Text('This is new router')),
    );
  }
}

// 路由传值
class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text, //接受一个Text参数
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('提示')),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                  onPressed: () => Navigator.pop(context, '我是返回值'),
                  child: Text('返回'))
            ],
          ),
        ),
      ),
    );
  }
}

// 新的TipRoute 的代码
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
            onPressed: () async {
              // 打开TipRoute 等待返回结果
              var result = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return TipRoute(
                      // 路由参数
                      text: '我是提示****');
                },
              ));
              //输出`TipRoute`路由返回结果
              print("路由返回值: $result");
            },
            child: Text('打开提示语')));
  }
}

// 命名路由参数传递
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: RaisedButton(onPressed: () async {
      //获取路由参数
      var args = ModalRoute.of(context).settings.arguments;
      print("路由返回值: $args");
    }));
  }
}

// widget 管理自身状态
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);
  @override
  _TapboxAState createState() => new _TapboxAState();
}

// 状态类
class _TapboxAState extends State<TapboxA> {
  // 定义状态
  bool _active = false;

  // 定义改变状态的事件
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  // 根据状态构建UI界面
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Container(
            child: Center(
                child: Text(_active ? 'Active' : 'Inactive',
                    style: TextStyle(fontSize: 32.0, color: Colors.white))),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: _active ? Colors.lightGreen[700] : Colors.grey[600],
            )));
  }
}

// 父类Widget 管理子widget的状态，对于父Widget来说，管理状态并告诉其子Widget何时更新通常是比较好的方式
// TapboxB通过回调将其状态导出到其父组件，状态由父组件管理，因此它的父组件为StatefulWidget。但是由于TapboxB不管理任何状态，所以TapboxB为StatelessWidget。
// 父组件
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

// 父状态组件
class _ParentWidgetState extends State<ParentWidget> {
  // 声明转态值
  bool _active = false;
  // 改变状态
  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  // 构建UI
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

class TapboxB extends StatelessWidget {
  // 参数校验及设置Key
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  // 状态的回调函数
  void _handleTap() {
    onChanged(!active);
  }

  // 子widget构建UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
            child: Text(
          active ? 'Active' : 'Inactive',
          style: new TextStyle(fontSize: 32.0, color: Colors.white),
        )),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// 混合状态管理，组件自身管理一些内部状态，而父组件管理一些其他外部状态。
class ParentWidgetC extends StatefulWidget{
  @override 
  _ParentWidgetCState createState()=> new _ParentWidgetCState();
}

// 父级维护的外部状态
class _ParentWidgetCState extends State<ParentWidgetC>{
  // 声明状态
  bool _active=false;
  // 触发更新状态
  void _handleTapboxChanged(bool newValue){
    setState(() {
      _active=newValue;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Container(
      // 组件的插入
      child: TapboxC(
        active:_active,
        onChanged:_handleTapboxChanged
      )
    );
  }
}

// 声明子组件
class TapboxC extends StatefulWidget{
  // 参数校验
  TapboxC({Key key,this.active:false,@required this.onChanged}):super(key:key);
  
  final bool active;
  final ValueChanged<bool> onChanged;
  // 声明自身的状态
  @override
  _TapboxCState createState()=> new _TapboxCState();

}

class _TapboxCState extends State<TapboxC>{

bool _highlight = false;
void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }
   @override
  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮  
    return new GestureDetector(
      onTapDown: _handleTapDown, // 处理按下事件
      onTapUp: _handleTapUp, // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? new Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }

}
