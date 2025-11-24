//---------------------------------task 1: -----------------------------------------
import java.sql.*;

class App {
    public static void main(String args[]) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // System.out.println("done1");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "a", "a");
            // System.out.println("done2");
            System.out.println("Connection to database successful ");
            String sqlQueryinward = "select distinct a.a_id , sum(t.amount) as total  from account a left join transactions t on a.a_id = t.a_id where t.type = 0 group by a.a_id";
            String sqlQueryoutward = "select distinct a.a_id , sum(t.amount) as total from account a left join transactions t  on a.a_id = t.a_id where t.type = 1 group by a.a_id";
            String sqlQuerytransactions = "select distinct a.a_id , sum(t.amount) as total from account a left join transactions t    on a.a_id = t.a_id  group by a.a_id";
            Statement statement1 = con.createStatement();
            Statement statement2 = con.createStatement();
            Statement statement3 = con.createStatement();
            ResultSet transactionsinward = statement1.executeQuery(sqlQueryinward);
            ResultSet transactionsoutward = statement2.executeQuery(sqlQueryoutward);
            ResultSet transactions = statement3.executeQuery(sqlQuerytransactions);
            int countcip = 0;
            int countvip = 0;
            int countop = 0;
            int countuncategory = 0;
            int counttotal = 0;

            while (transactionsinward.next()) {
                transactionsoutward.next();
                transactions.next();
                counttotal++;
                int inward = transactionsinward.getInt("total");
                int outward = transactionsoutward.getInt("total");
                int total = transactions.getInt("total");
                int balance = inward - outward;
                // System.out.println("total: " + total);
                if (total > 5000000 && balance > 1000000) {
                    countcip++;
                } else if (balance > 500000 && total > 2500000) {
                    countvip++;
                } else if (balance < 100000 && total < 1000000) {
                    countop++;
                } else {
                    countuncategory++;
                }
            }
            System.out.println("Total Number of Accounts : " + counttotal);
            System.out.println("CIP count : " + countcip);
            System.out.println("VIP count : " + countvip);
            System.out.println("Ordinary count : " + countop);
            System.out.println("Uncategorized : " + countuncategory);
            
            //---------------------task 2: prepared statements------------------------
            PreparedStatement pStmt = con.prepareStatement("insert into transactions values (?,to_date(?, 'YYYY-MM-DD'),?,?,?)");
            pStmt.setInt(1 ,10001);
            pStmt.setString (2 ,"2022-02-12");
            pStmt.setInt (3 ,2);
            pStmt.setInt (4 ,5000);
            pStmt.setInt (5 ,1);
            pStmt.executeUpdate();
            PreparedStatement pStmt2 = con.prepareStatement("insert into transactions values (?,to_date(?, 'YYYY-MM-DD'),?,?,?)");
            pStmt2.setInt(1 ,10005);
            pStmt2.setString (2 ,"2022-10-15");
            pStmt2.setInt (3 ,4);
            pStmt2.setInt (4 ,10000);
            pStmt2.setInt (5 ,0);
            pStmt2.executeUpdate();

            // -----------------------------task 3: metadata------------------------------
            //transactions entity:
            String sqlQuery = "select * from transactions";
            Statement statement5 = con.createStatement();
            ResultSet result = statement5.executeQuery(sqlQuery);
            ResultSetMetaData rsmd = result.getMetaData();
            System.out.println("Entity name: transactions");
            System.out.println("Number of columns :" + rsmd.getColumnCount());
            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                System.out.printf("Column Name: \""+ rsmd.getColumnName(i)+ "\"");
                System.out.println(" Data type: "+rsmd.getColumnTypeName(i));
            }
            //Account entity:
            String sqlQuery2 = "select * from account";
            Statement statement6 = con.createStatement();
            ResultSet result2 = statement6.executeQuery(sqlQuery2);
            ResultSetMetaData rsmd2 = result2.getMetaData();
            System.out.println("Entity name: account");
            System.out.println("Number of columns :" + rsmd2.getColumnCount());
            for (int i = 1; i <= rsmd2.getColumnCount(); i++) {
                System.out.printf("Column Name: \""+ rsmd2.getColumnName(i)+ "\"");
                System.out.println(" Data type: "+rsmd2.getColumnTypeName(i));
            }
        } catch (Exception e) {
            System.out.println(e);
            // System.out.println("done");
        }
    }
}