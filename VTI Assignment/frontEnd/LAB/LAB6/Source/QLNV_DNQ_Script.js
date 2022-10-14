// Trong bài tập này sẽ xử dụng Jquery và JavaScript để thực hiện chức năng quản lý nhân viên, tương ứng với bảng Account trong DB TestingSystem, Các chức năng: Thêm, Sửa, Xóa
// Khai báo 1 array để lưu thông tin tất cả các Account trên hệ thống.
var listAccount = []
$(function(){    
// Hàm thực thi khi load đầy đủ các thành phần html
    $('#reset_btn').click(function(){
// Xử lý sự kiện cho nút reset, Sử dụng JQuery để lấy các giá trị các trường theo ID, sau đó Set về rỗng
        $('#ID_ID').val("")
        $('#Email_ID').val("")
        $('#Username_ID').val("")
        $('#Fullname_ID').val("")
        $('#Department_ID').val("")
        $('#Position_ID').val("")
        $('#Cretate_Date_ID').val("")
    })
    $('#Main_Form_ID').submit(function(){
// Xử lý sự kiện khi nhấn nút Submit của Form(Save), ở đây phải sử dụng Return False ở cuối sự kiện này để không redirect sang trang mới.
        var v_ID_ID = $('#ID_ID').val()
        var v_Email_ID = $('#Email_ID').val()
        var v_Username_ID = $('#Username_ID').val()
        var v_Fullname_ID = $('#Fullname_ID').val()
        var v_Department_ID = $('#Department_ID').val()
        var v_Position_ID = $('#Position_ID').val()
        var v_Cretate_Date_ID = $('#Cretate_Date_ID').val() 
// Tạo 1 đối tượng account để lưu giữ thông tin nhận được
        var account = {
            'ID': v_ID_ID,
            'Email': v_Email_ID,
            'Username': v_Username_ID,
            'Fullname':v_Fullname_ID,
            'Department':v_Department_ID,
            'Position':v_Position_ID,
            'Cretate_Date':v_Cretate_Date_ID
        }
// Add account vào array
        listAccount.push(account)
// Hàm này để hiển thị thông tin account ở table
        showAccount()
        return false;
// Sử dụng return false để không redirect tới 1 trang khác.
    })   
})

// Viết hàm showAccount()
function showAccount(){
    // Xóa hết kết quả đang hiển thị ở bảng kết quả
            $('#Result_TB').empty()
    // Lặp trong listAccount để in thông tin từng phần tử
    // Hiển thị thêm 2 nút để sửa và xóa các Account
            for (var index = 0; index < listAccount.length; index++) {
              $('#Result_TB').append(`
              <tr>
              <th>${listAccount[index].ID}</th>
              <th>${listAccount[index].Email}</th>
              <th>${listAccount[index].Username}</th>
              <th>${listAccount[index].Fullname}</th>
              <th>${listAccount[index].Department}</th>
              <th>${listAccount[index].Position}</th>   
              <th>${listAccount[index].Cretate_Date}</th>
              <th><button class="btn btn-warning" onclick="editAccount(${index})">Edit</button></th>
              <th><button class="btn btn-warning" onclick="deleteAccount(${index})">Delete</button></th>
              </tr>
              `)                  
            }
        }
    // Viết hàm xóa account
        function deleteAccount(Index){
    // Hiển thị 1 Confim Popup, chọn Có = True
           var confirm_del = confirm('Bạn có chắc chắn muốn xóa Account này không')
           if (confirm_del) {
               listAccount.splice(Index,1)
               showAccount()
           }else{
            return
           }
        }
    // Viết hàm để Edit các account
        function editAccount(Index){
            $('#ID_ID').val(listAccount[Index].ID)
            $('#Email_ID').val(listAccount[Index].Email)
            $('#Username_ID').val(listAccount[Index].Username)
            $('#Fullname_ID').val(listAccount[Index].Fullname)
            $('#Department_ID').val(listAccount[Index].Department)
            $('#Position_ID').val(listAccount[Index].Position)
            $('#Cretate_Date_ID').val(listAccount[Index].Cretate_Date)
    //  Xử lý sự kiện khi click vào nút Update 
            $('#update_btn').click(function(){
                var v_ID_ID = $('#ID_ID').val()
                var v_Email_ID = $('#Email_ID').val()
                var v_Username_ID = $('#Username_ID').val()
                var v_Fullname_ID = $('#Fullname_ID').val()
                var v_Department_ID = $('#Department_ID').val()
                var v_Position_ID = $('#Position_ID').val()
                var v_Cretate_Date_ID = $('#Cretate_Date_ID').val() 
        
                listAccount[Index].ID = v_ID_ID
                listAccount[Index].Email = v_Email_ID
                listAccount[Index].Username = v_Username_ID
                listAccount[Index].Fullname = v_Fullname_ID
                listAccount[Index].Department = v_Department_ID
                listAccount[Index].Position = v_Position_ID
                listAccount[Index].Cretate_Date = v_Cretate_Date_ID
                showAccount()
            })
        }

















        