# ASP.NET Core

-----------

# 	Entity Framework Core

ORM(对象关系)

![image-20210702154209083](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702154209083.png)



- 两种模式

  - 代码先行(Code First)

    ![image-20210702154319502](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702154319502.png)

  - 数据库先性(DB First)

    ![image-20210702154359627](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702154359627.png)

- 多层体系架构-SOA架构

  界面层、业务逻辑层、数据访问层

- 领域驱动设计

  ![image-20210702155003387](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702155003387.png)

  ![image-20210702155213670](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702155213670.png)

- EFCore依赖

  ![image-20210702155303635](C:\Users\lilinfei\AppData\Roaming\Typora\typora-user-images\image-20210702155303635.png)

- DbContex

  - 创建

  ```c#
  public class AppDbContext : DbContext // 继承
  {
      // 实例化——构造函数
      // 使用options继承于base的形式将应用程序的配置信息传递给DbContext
      public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
      {
  	}
    
      // 声明实体类 DbSet<TEntity> 泛型
      public DbSet<Student> Students {get; set;}
  }
  ```

  - 连接

    官网：数据库提供程序

    ```c#
    // Startup.cs中配置
    services.AddDbContextPool<AppDbContext>(
    	options => options.UseSqlServices(....)
    );// 数据库连接池
    
    // appsetting.json
    // 连接字符串
    ConnectionString = ''
    ```

  - 仓储模式

    - 仓储接口

    ```c#
    public interface IStudentRepository
    {
        Student GetStudent(int id);
        
        IEnumberable<Student> GetAllStudents();
        
        Student Add(Studnet student);
        
        Student Update(Student updateStudent);
        
        Student Delete()
    }
    ```

    

- 迁移功能

  安装全局工具

  	dotnet tool install --global dotnet-ef

  安装所需包

  	dotnet add package Microsoft.EntityFrameworkCore.Design

  验证安装成功

  	dotnet ef 

  显示


                       _/\__
      ---==/    \\
           ___  ___   |.    \|\
      | __|| __||)   \\\
      | _|| _|   \_/|//|\\
      |___||_|/   \\\/\\
      EntityFrameworkCore.NET Command-line Tools2.1.3-rtm-32065
      <Usage documentation follows,not shown.>

  更新

  	dotnet tool update dotnet-ef [--version<VERSION>]

  默认状态，当前目录为启动项目，设置启动项目

  	dotnet ef --startup-project <PATH> add NAME

  创建新的迁移文件

  	dotnet ef migrations add NAME

  查询迁移列表

  	dotnet ef migrations list

  迁移删除(回滚上一版本)

  	dotnet ef migrations remove

  迁移脚本(生成SQL脚本)

  	dotnet ef migrations script

  更新数据库

  	dotnet ef database update

  删除数据库

  	dotnet ef database update drop

  基架生成(从数据库中生成实体类)
  	

  	dotnet ef dbcontext scaffold <CONNECTION> <NuGetPackage>

  eg:

  	dotnet ef dbcontext scaffold "Server=(localdb)\mssqllocaldb;Database=Blogging;Trusted_Connection=True;"Microsoft.EntityFrameworkCore.SqlServer-o Models 

  添加新表

  	dotnet ef migrations add TABLENAMEs

  


- 种子数据

  为数据库添加初始值

```c#
// DbContext文件中
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    modelBuilder.Entity<Student>().HasData(
        new Stuudent
        {
            id = 1;
            Name = 'hsdhs';
        },
    	new Student 
        {
		})
}

// 执行迁移语句
dotnet ef add-migration 
dotnet ef uodate database
   
// 创建扩展文件
ModelBuilderExtenskions.cs
    // 扩展方法要用静态类
public static class ModelBuilderExtensions
{
    public static void Seed(this ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Student>().HasData(
        new Stuudent
        {
            id = 1;
            Name = 'hsdhs';
        },
    	new Student 
        {
		})
    }
}


// 在Dbcontext文件中使用
// DbContext文件中
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    modelBuilder.Seed();  // 引用方法
}
```

- 保持同步

  ```c#
  ```



## 依赖注入


