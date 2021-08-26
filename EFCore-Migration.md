# ASP.NET Core & EFCore自动生成

## 1.打开PM
视图->其他窗口->程序包管理控制台

## 2.连接数据库并创建表
PM> 

```c
Scaffold-DbContext "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=8.133.172.152)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User ID=ADMIN;Password=yuanayi;Persist Security Info=True" Oracle.EntityFrameworkCore -Table ADMIN.ACTIVITY, ADMIN.ADD_SHOPPING_CART, ADMIN.ADMINISTRATOR, ADMIN.BUYER, ADMIN.BUYER_COUPON,ADMIN.CHATROOM, ADMIN.CHATUSER, ADMIN.COMMODITY, ADMIN.COUNTER, ADMIN.COUPON, ADMIN.COUPON_SHOP, ADMIN.FAVORITE_PRODUCT, ADMIN.FOLLOW_SHOP, ADMIN.MESSAGE, ADMIN.ORDER, ADMIN.ORDERS_COMMODITY, ADMIN.RECEIVE_INFORMATION, ADMIN.SELLER, ADMIN.SHOP -OutputDir Models -force
```



	Scaffold-DbContext "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=1.117.90.50)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User ID=ADMIN;Password=yuanayi;Persist Security Info=True" Oracle.EntityFrameworkCore -Table ADMIN.ACTIVITY, ADMIN.ADD_SHOPPING_CART, ADMIN.ADMINISTRATOR, ADMIN.BUYER, ADMIN.BUYER_COUPON, ADMIN.COMMODITY, ADMIN.COUPON, ADMIN.COUPON_SHOP, ADMIN.FAVORITE_PRODUCT, ADMIN.FOLLOW_SHOP, ADMIN.MESSAGE, ADMIN.ORDERS, ADMIN.ORDERS_COMMODITY, ADMIN.RECEIVE_INFORMATION, ADMIN.SELLER, ADMIN.SHOP -OutputDir Models -force

## 3.添加Controllers



在controller文件中添加控制器，共16个表，可生成16个controller(如果出现报错，可关闭重试，没啥问题)

## 4.删除一个字符串
在models下的ModelContext中找到如下串，直接删除（否则暴露连接信息）

	  #warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
	          "optionsBuilder.UseOracle(\"Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=1.117.90.50)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User ID=ADMIN;Password=yuanayi;Persist Security Info=True\");"

## 5.byte=>short
在生成的Models文件中，每一个表的.cs文件中有的属性类型不太对，目前时将byte改为short,bool有的改为int,比如gender。（bool严格要求输入True/False)。

## 6.Startup.cs修改
1.将Startup方法中改为

	 public Startup(IConfiguration configuration)
	    {
	        var builder = new ConfigurationBuilder()
	            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
	        Configuration = configuration;
	    }

2.ConfigureServices改为：

	 public void ConfigureServices(IServiceCollection services)
	    {
	        services.AddRazorPages();
	        services.AddDbContext<ModelContext>(options => options.UseOracle(Configuration.GetConnectionString("OracleDBContext")));
	        services.AddControllersWithViews();
	    }

## 7.appsetting.json修改
加入如下ConnectionStrings：

 	"ConnectionStrings": {
 	"OracleDBContext": "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=1.117.90.50)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User ID=ADMIN;Password=yuanayi;Persist Security Info=True;"
  }

（在“AllowedHosts”:"*"后加个逗号,）


## 8.重新生成解决方案

## 9.运行，输入路由即可查看
网页修改后用sqldeveloper中查看是否修改成功