-- 1. Tạo CSDL có tên JW240711_DB
create database JW240711_DB;
-- 2. Xóa CSDL có tên JW240711_DB
drop database JW240711_DB;
-- 3. Tạo CSDL có tên Demo
create database Demo;
-- 4. Sử dụng CSDL Demo để tạo các đối tượng bảng
use Demo;
/*
	5. Tạo bảng Danh mục gồm các trường (column) sau:
    - Mã danh mục: số nguyên, khóa chính (= not null + unique), tự tăng
    - Tên danh mục: varchar(100), bắt buộc nhập, không được trùng lặp
    - Mô tả: text, không bắt buộc nhập
    - Trạng thái: bit, mặc định là 1 (true)
*/
create table Categories(
	-- Column_name Datatype constraints
	cat_id int primary key auto_increment,
    cat_name varchar(100) not null unique,
    -- Mặc định là cho phép null
    cat_descriptions text,
    cat_status bit default(1)
);
/*
	6. Tạo bảng Product gồm các trường sau:
    - Mã sản phẩm: char(5), khóa chính
    - Tên sản phẩm: varchar(200), not null và không trùng lặp
    - Giá sản phẩm: float, not null và bắt buộc có giá trị lớn hơn 0
    - Mô tả sản phẩm: text,
    - Mã danh mục: số nguyên, khóa ngoại tham chiếu tới bảng Categories,
    - Trạng thái: bit
*/
create table product(
	product_id char(5) primary key,
    product_name varchar(200) not null unique,
    product_price float not null check(product_price>0),
    product_descriptions text,
    cat_id int,
    foreign key(cat_id) references categories(cat_id),
    product_status bit    
);
/*
	7. Tạo bảng User gồm các thông tin sau:
		- Mã người dùng: int, khóa chính, tự tăng
        - Tên người dùng: varchar(50), not null, unique
        - Mật khẩu: varchar(50), not null
        - Địa chỉ: text
        ....
        - Trạng thái tinyint (0 - hoạt động, 1 - block, 2 - Không hoạt động)
	8. Tạo bảng Order gồm các thông tin sau:
		- Mã hóa đơn: int, khóa chính, tự tăng
        - Ngày tạo: date, not null
        - Tổng tiền: float
        - Trạng thái: bit, default 0
	9. Tạo bảng Order_Detail gồm các thông tin sau:
		- Mã hóa đơn: int, FK
        - Mã sản phẩm: char(5), Fk
        - Số lượng sản phẩm: int
        - Giá sản phẩm: float - Lưu giá sản phẩm tại thời điểm mua        
*/
create table App_user(
	user_id int primary key auto_increment,
    user_name varchar(50) not null unique,
    user_password varchar(50) not null,
    user_address text,
    user_status enum("0","1","2")
);
create table App_Order(
	order_id int primary key auto_increment,
    order_created date not null,
    order_total_amount float,
    ordere_status bit default(0)
);

-- Thêm cột test có kiểu dữ liệu text, not null vào bảng App_Order
alter table App_Order
	add column Test text not null;
-- Xóa cột test của bảng App_Order
alter table App_Order
	drop column Test;
-- Sửa kiểu dữ liệu của cột total_amount thành double
alter table App_Order
	modify column order_total_amount double;
    
-- Sửa cấu trúc bảng: thêm cột user_id: int, FK tham chiếu đến App_user
-- B1: Tạo cột user_id có kiểu dữ liệu int
alter table App_order
	add user_id int not null;
-- B2: Thêm rằng buộc FK cho cột user_id
alter table App_order
	add constraint foreign key(user_id) references App_user(user_id);
create table Order_Detail(
	product_id char(5),
    foreign key(product_id) references product(product_id),
    order_id int,
    foreign key(order_id) references App_Order(order_id),
    primary key(product_id,order_id),
    quantity int not null,
    price float not null
);


