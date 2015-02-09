class OracleTableController < ApplicationController
  @@sql = %{SELECT owner || '.' || table_name as t
          FROM all_tables
          order by owner, table_name}

  def list_tables
    @table_array = []
    conn = nil
    statement = nil
    results = nil

    begin
      conn = $pool.get_connection
      statement = conn.createStatement

      # for multi-threaded testing uncomment the sleep
      # sleep 3

      results = statement.executeQuery(@@sql)

      while results.next do
        row = results.getObject('t').to_s
        @table_array << row
      end
    rescue => ex
      puts "Something went wrong. The error returned was #{ex}."
    ensure
      $pool.return_connection(conn) unless conn.nil?
      results.close unless results.nil?
      statement.close unless statement.nil?
    end
  end
end
