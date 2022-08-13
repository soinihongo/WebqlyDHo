// var listwatchblock = document.querySelector('#listwatchblock');
var watchApi = 'http://localhost:5500/api/listwatch'
var employeeApi = 'http://localhost:5500/api/listemployee'
var customerApi = 'http://localhost:5500/api/listcustomer'
var branchApi = 'http://localhost:5500/api/listbranch'
var billApi = 'http://localhost:5500/api/listbill'
function start() {
  getEmployees(renderemployee);
  getWatches(renderwatch);
  getCustomers(rendercustomer);
  getBranch(renderbranch);
  getBill(renderbill);
  
  handleCreateForm_employee();
};
start();

//function ở dưới này
// laasy danh sach wwatch
function getWatches(callback) {
  fetch(watchApi)
    .then(function (response) {
      return response.json();
    })
    .then(callback)
};

function renderwatch(watches) {
  var listwatchblock =
    document.querySelector('#listwatchblock');
  var htmls = watches.map(function (watch) {
    return `<div class="col-md-6 col-xl-3">
                    <div class="box">
                      <a >
                        <div class="img-box">
                          <img src="${watch.LinkAnh}" alt="">
                        </div>
                        <div class="detail-box">
                          <h6>
                            ${watch.TenSanPham}
                          </h6>
                          <h6>
                            Price:<br>
                            <span>
                              ${watch.GiaBan} triệu<br>VNĐ
                            </span>
                          </h6>
                        </div>
                        <div class="new">
                          <span>
                            ${watch.ThuongHieu}  
                          </span>
                        </div>
                      </a>
                    </div>
                  </div>`;
  })
  listwatchblock.innerHTML = htmls.join('');
}

function getEmployees(callback) {
  fetch(employeeApi)
    .then(function (response) {
      return response.json();
    })
    .then(callback)
};

function createEmployees(data,callback){
  var options = {
    method:'POST',
    headers: {'Content-Type':'application/json'},
    body: JSON.stringify(data)
  };
  fetch(employeeApi,options)
    .then(function (response) {
      return response.json();
    })
    .then(callback);
}

function renderemployee(employees) {
  var listemployee =
    document.querySelector('#listemployee');
  var htmls = employees.map(function (employee) {
    return `<tr>
              <td>${employee.MaNV}</td>
              <td>${employee.TenNhanVien}</td>
              <td>${employee.GioiTinh}</td>
              <td>${employee.NgaySinh}</td>
              <td>${employee.CCCD}</td>
              <td>${employee.Email}</td>
              <td>${employee.SDT}</td>
              <td>${employee.LuongCung}.000.000</td>
              <td>${employee.Thuong}.000.000</td>
              <td>${employee.LuongCung + employee.Thuong}.000.000</td>
              <td align="center">
                  <a class="add" type="button" title="Lưu Lại" data-toggle="tooltip"><i class="fa fa-floppy-o"
                          aria-hidden="true"></i></a><br>
                  <a class="edit" type="button" title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
                          aria-hidden="true"></i></a><br>
                  <a class="delete" type="button" title="Xóa" data-toggle="tooltip"><i class="fa fa-trash-o"
                          aria-hidden="true"></i></a>
              </td>
            </tr>`;
  })
  listemployee.innerHTML = htmls.join('');
}

function handleCreateForm_employee(){
  var createBtn = document.querySelector('#createEmployee');

  createBtn.onclick=function(){
    // 
    var MaNV =        document.querySelector('input[name="MaNV"]').value;
    var TenNhanVien = document.querySelector('input[name="TenNhanVien"]').value;
    var GioiTinh =    document.querySelector('input[name="GioiTinh"]').value;
    var NgaySinh =    document.querySelector('input[name="NgaySinh"]').value;
    var CCCD =        document.querySelector('input[name="CCCD"]').value;
    var Email =       document.querySelector('input[name="Email"]').value;
    var SDT =         document.querySelector('input[name="SDT"]').value;
    var formEmployee = {
      MaNV:MaNV,
      TenNhanVien:TenNhanVien,
      GioiTinh:GioiTinh,
      NgaySinh:NgaySinh,
      CCCD:CCCD,
      Email:Email,
      SDT:SDT
    };
    console.log(formEmployee);alert(formEmployee)
    createEmployees(formEmployee);
  }
}


function getCustomers(callback) {
  fetch(customerApi)
    .then(function (response) {
      return response.json();
    })
    .then(callback)
};

function rendercustomer(customers) {
  var listcustomer =
    document.querySelector('#listcustomer');
  var htmls = customers.map(function (customer) {
    return `<tr>
    <td>${customer.MaKH}</td>
    <td>${customer.TenKhachHang}</td>
    <td align="center">${customer.GioiTinh}</td>
    <td>${customer.DiaChi}</td>
    <td>${customer.SDT}</td>
    <td>${customer.Email}</td>
    <td align="center">
        <a class="add" type="button" title="Lưu Lại" data-toggle="tooltip"><i class="fa fa-floppy-o"
                aria-hidden="true"></i></a><br>
        <a class="edit" type="button" title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
                aria-hidden="true"></i></a><br>
        <a class="delete" type="button" title="Xóa" data-toggle="tooltip"><i class="fa fa-trash-o"
                aria-hidden="true"></i></a>
    </td>
</tr>`;
  })
  listcustomer.innerHTML = htmls.join('');
}

function getBranch(callback) {
  fetch(branchApi)
    .then(function (response) {
      return response.json();
    })
    .then(callback)
};

function renderbranch(branches) {
  var listbranch = document.querySelector('#listbranch');
  var htmls = branches.map(function (branch) {
    return `<tr>
    <td>${branch.MaCN}</td>
    <td>${branch.DiaChi}</td>
    <td>${branch.DoanhThu}</td>
    <td align="center">
      <a class="add" type="button" title="Lưu Lại" data-toggle="tooltip"><i class="fa fa-floppy-o"
          aria-hidden="true"></i></a><br>
      <a class="edit" type="button" title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
          aria-hidden="true"></i></a><br>
      <a class="delete" type="button" title="Xóa" data-toggle="tooltip"><i class="fa fa-trash-o"
          aria-hidden="true"></i></a>
    </td>
  </tr>`;
  })
  listbranch.innerHTML = htmls.join('');
}


// tạo fetch Bill
function getBill(callback) {
  fetch(billApi)
    .then(function (response) {
      return response.json();
    })
    .then(callback)
};

function renderbill(billes) {
  var listbill = document.querySelector('#listbill');
  var htmls = billes.map(function (bill) {
    return `<tr>
    <td>${bill.MaHD}</td>
    <td>${bill.MaKH}</td>
    <td>${bill.MaNV}</td>
    <td>${bill.MaCN}</td>
    <td>${bill.MaSP}</td>
    <td>${bill.SoLuong}</td>
    <td>${bill.NgayBan}</td>
    <td>${bill.ThanhTien}</td>
    <td align="center">
        <a class="add" type="button" title="Lưu Lại" data-toggle="tooltip"><i class="fa fa-floppy-o"
                aria-hidden="true"></i></a><br>
        <a class="edit" type="button" title="Sửa" data-toggle="tooltip"><i class="fa fa-pencil"
                aria-hidden="true"></i></a><br>
        <a class="delete" type="button" title="Xóa" data-toggle="tooltip"><i class="fa fa-trash-o"
                aria-hidden="true"></i></a>
    </td>
</tr>`;
  })
  listbill.innerHTML = htmls.join('');
}