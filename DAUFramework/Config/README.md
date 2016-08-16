#1.框架组成
框架采用字典数据结构实现的一套KV系统，所有对象的存取依赖Key和Scope，Key通常为对象名，Scope是其作用域

* 数据：核心模块，即抽象出来的KV系统，K和V可以为任意类型对象数据模块负责保存所有对象的实例，并且保证数据可以通过Key和Scope得到访问。    

* 事件：对方法即函数的封装，将函数当做对象看到可以放入KV系统中  

* 界面：对所有UI组件的简单封装，因为OC框架中UI类的对象没有实现拷贝构造，不能直接放入KV系统  

* 绑定关系：系维护数据、事件及界面之间的关联，依赖KV系统实现  


#2.ModelDefine语法说明
model采用KV系统实现，将所有model数据抽象为一种对象
##1.1关键字：
描述文件使用Key作为对象名
scope：作用域
varname：如果包含此字段，则对象名使用此Key对应的Value，如果名称以$开头，则对象名为此Key对应的Value为Key的Value作为对象名
propertys：对象的属性Key为属性名称，Value为属性类型

##1.2例子：
```JSON
定义
"note":
{
    "scope":"note",
    "varname":"$noteId",
    "propertys":
    {
        "noteId": "string",
        "content": "string",
        "bucket": "string",
        "attachmentUrl": "string",
        "attachmentWidth": "string",
        "attachmentHeight": "string",
        "likeCount": "string",
        "hateCount": "string",
        "commentCount": "string",
        "userId": "string",
        "gameId": "string",
        "time": "string",
        "collectionCount": "string",
        "originNoteId": "string",
        "state": "string",
        "visible": "string"
    }
}

数据
{
    "noteId": "170833264763083776",
    "content": "%E6%83%B3%E7%8E%A9%E9%BE%99%E8%99%BE%E9%98%B5%20%E6%80%8E%E4%B9%88%E7%8E%A9%EF%BC%9F",
    "bucket": "gamecircle-pic",
    "attachmentUrl": "838cfe67b39414af633fe61f792ff52e.jpg",
    "attachmentWidth": "421",
    "attachmentHeight": "750",
    "likeCount": "18",
    "hateCount": "1",
    "commentCount": "2",
    "userId": "49365430695821313",
    "gameId": "58155557995347969",
    "time": "20160419134106",
    "collectionCount": "0",
    "originNoteId": "0",
    "state": "0",
    "visible": "0"
}
```
输入JSON数据解析后在Model的KV系统中保存形式为在"note"作用域下，“170833264763083776”为Key，Value为包含所有数据的字典

```oc
    Data * note = [Data dataWithKey:@"170833264763083776" withScope:@"note"];
    note[@"userId"] = @"123456";
```


