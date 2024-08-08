<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("submit") != null) {
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/school_database", "root", "");
            preparedStatement = conn.prepareStatement("insert into student_table(studentName, course, fee) values(?, ?, ?)");
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, course);
            preparedStatement.setString(3, fee);
            preparedStatement.executeUpdate();
%>
    <script>
        alert("Record added successfully");
    </script >
<%
        } catch (Exception e) {
            e.printStackTrace();
%>
    <script>
        alert("Error adding record: <%= e.getMessage()%>");
    </script>
<%
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web App</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap.min.css" rel = "stylesheet" type="text/css"/>

        <style>
            h1 {
                text-align:  center; /* Center the heading horizontally */
            }
        </style>

    </head>
    <body>
        <h1>Student Registration System CRUD using JSP</h1>
        <br>
        <div class="row">
            <div class="col-sm-4"> <!--for form-->
                <form method="POST" action="#">
                    <div alight="left">
                        <label class="form-label">Student Name</label>
                        <input type="text" class="form-control" placeholder="Student Name" name="sname" id="sname" required>
                    </div>
                    <div alight="left">
                        <label class="form-label">Course</label>
                        <input type="text" class="form-control" placeholder="Course" name="course" id="course" required>
                    </div>
                    <div alight="left">
                        <label class="form-label">Fee</label>
                        <input type="text" class="form-control" placeholder="Fee" name="fee" id="fee" required>
                    </div>
                    <br>
                    <div alight="right">
                        <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                        <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                    </div>
                </form>
            </div>

            <div class="col-sm-8"> <!--for table-->
                <div class="panel-body">
                    <table id="table-student" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                        <thead>
                            <tr>
                                <th>Student Name</th>
                                <th>Course</th>
                                <th>Fee</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                            <%
                                Connection conn = null;
                                PreparedStatement preparedStatement = null;
                                ResultSet resultSet = null;
                                
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost/school_database", "root", "");
                                
                                String query = "select * from student_table";
                                Statement statement = conn.createStatement();
                                resultSet = statement.executeQuery(query);
                                
                                while(resultSet.next()){
                                    String id = resultSet.getString("id");
                            %>
                            
                            <tr>
                                <td><%=resultSet.getString("studentName") %></td>
                                <td><%=resultSet.getString("course") %></td>
                                <td><%=resultSet.getString("fee") %></td>
                                <td><a href="update.jsp?id=<%=id%>">Edit</a></td>
                                <td><a href="delete.jsp?id=<%=id%>">Delete</a></td>
                            </tr>
                            
                            <%
                                }
                            %>
                            
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
