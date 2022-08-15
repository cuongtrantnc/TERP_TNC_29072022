using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Libs
{
    public class DbHelper
    {
        public static DataTable getDataTable(string sql, string connectionString)
        {
            DataTable dataTable = new DataTable();

            try
            {
                SqlConnection conn = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                // create data adapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // this will query your database and return the result to your datatable

                da.Fill(dataTable);
                conn.Close();
                da.Dispose();
            }
            catch (Exception ex)
            {
                return null;
            }

            return dataTable;
        }

        public static DataTable getDataTableEx(string sql, string tables, string connectionString)
        {
            return null;
        }

        public static DataTable getDataTableEx2(string sql, string connectionString)
        {
            return null;
        }

        public static DataRow getDataRow(string sql, string connectionString)
        {
            DataTable dt = getDataTable(sql, connectionString);

            return (dt == null || dt.Rows.Count == 0) ? null : dt.Rows[0];
        }

        public static void insertBulkIntoDatabase(DataTable dataTable, string tableName, string tableFields)
        {

        }

        public static void insertBulkIntoDatabaseWithConnectionString(string cs, DataTable dataTable, string tableName, string tableFields)
        {
            using (var connection = new SqlConnection(cs))
            {
                SqlTransaction transaction = null;
                connection.Open();
                try
                {
                    transaction = connection.BeginTransaction();
                    using (var sqlBulkCopy = new SqlBulkCopy(connection, SqlBulkCopyOptions.TableLock, transaction))
                    {
                        sqlBulkCopy.DestinationTableName = tableName;
                        sqlBulkCopy.BulkCopyTimeout = 2000;

                        string[] a_tableFields = tableFields.Split(',');

                        for (int i = 0; i < a_tableFields.Length; i++)
                        {
                            sqlBulkCopy.ColumnMappings.Add(a_tableFields[i].Trim(), a_tableFields[i].Trim());
                        }

                        sqlBulkCopy.WriteToServer(dataTable);
                    }
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw;
                }
                connection.Close();
            }
        }

        public static void doQuery(Control ctl,string connection_string, string query_name, string[] param_name, string[] param_value)
        {
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection(connection_string);
                conn.Open();

                SqlCommand cmd = new SqlCommand(query_name, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 0;

                if (param_name != null && param_value != null && param_name.Length==param_value.Length)
                {
                    for (int i = 0; i < param_name.Length; i++)
                    {
                        cmd.Parameters.AddWithValue(param_name[i], param_value[i]);
                    }
                }
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                //(new Mess(ctl)).ShowMessageBar(ex.Message, Mess.TYPE_NG);
            }
            finally
            {
                if (conn != null) conn.Close();
            }
        }

        public static string getRowCount(SqlDataSource source)
        {
            DataView dv = (DataView)source.Select(DataSourceSelectArguments.Empty);
            dv.RowFilter = source.FilterExpression;
            
            return dv.Count.ToString();
        }
    }
}