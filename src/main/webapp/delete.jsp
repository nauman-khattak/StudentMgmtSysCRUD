<%@page import="java.sql.*"%>
<%
    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement preparedStatement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/school_database", "root", "");
        preparedStatement = conn.prepareStatement("delete from student_table where id = ?");
        preparedStatement.setString(1, id);
        preparedStatement.executeUpdate();
%>
    <script>
        alert("Record deleted successfully");
    </script >
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Error deleting record: <%= e.getMessage()%>");
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
%>