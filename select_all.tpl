<!DOCTYPE html>
<html>
<head>
</head>
<style>
table {
  font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
  font-size: 14px;
  text-align: left;
  border-collapse: collapse;
  border-radius: 20px;
  box-shadow: 0 0 0 ;
}
th {
  padding: 10px 8px;
  background: white;
}
table th:first-child {
  border-top-left-radius: 20px;
}
table th:last-child {
  border-top-right-radius: 20px;
}
td {
  padding: 8px;
  background: white;
}
table td:first-child {
  border-bottom-left-radius: 20px;
}
table td:last-child {
  border-bottom-right-radius: 20px;
}

.table-wrap{
	overflow-x:auto;
}	
table.table-1 {
    border-collapse: collapse;
    border-spacing: 0;
    width: 100%;
}
table.table-1 tr {
	background-color: #f8f8f8;
}
table.table-1 th, table.table-1 td {
	text-align: left;
    padding: 8px;
    border: 1px solid #ddd;
}

table.table-1 th{
	font-weight: bold;
}
#myTable tr.header, #myTable tr:hover {
    background-color: #f1f1f1
}

#myInput {
    width: 100%;
    font-size: 16px;
    padding: 12px 20px 12px 40px;
     margin-bottom: 12px;
}
</style>
<p>Добавьте новые данные в базу</p>
<form action="/insert" method="GET">
    <input type="text" size="100" maxlength="100" name="link" placeholder="Введите ссылку">
    <input type="submit" name="save" value="save">
</form>
<div class='table-wrap'>
<table id="myTable" class='table-1'>
<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Поиск по заголовку...">
<tr class="header">
<th>Заголовок</th><th>Подписка</th><th>Ссылка</th>
</tr>
    %for col in result:
    <tr>
        <td>{{col[0]}}</td>
        <td>{{col[1]}}</td>
        <td>{{col[2]}}</td>
    </tr>
    %end
</table>
</div>
<script>
function myFunction() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}


function makeEditable(e) {
    var cell = e.target;
    if (cell.dataset.editing !== 'true') {
      cell.dataset.editing = true;
      var text = cell.innerHTML;
      cell.innerHTML = '';
      var input = document.createElement('input');
      input.addEventListener('blur', makeNonEditable);
      input.type = 'text'
      input.value = text;
      cell.appendChild(input);
    } 
}

function makeNonEditable(e) {
  var input = e.target;
  var taxt = input.value;
  var cell = input.parentElement;
  if (cell.dataset.editing === 'true') {
    cell.dataset.editing = false;
  }
}


table = document.getElementById("myTable")
var tr = table.getElementsByTagName("tr")
for (i = 0; i < tr.length; i++) {
  td = tr[i].getElementsByTagName("td")[0];
  if (td) {
    td.addEventListener('mousedown', makeEditable);
  }
}
</script>
</html>