require 'pg'

freq = '1m'

begin
  # Postgres connection
conn  = PG.connect(  host:"localhost",port:5432,dbname:"crypto",user: "myapp",password:"password1")

  # SQL query - simplified because lazy
  sql = "select hash,price from historicalorders limit 1"

  SCHEDULER.every freq do
    # hit ratio
    res=conn.exec(sql)
    hash_price = []  # rebuild the list every time
    hash_price << { label: 'hash', value: res[0]['hash'] }
    hash_price << { label: 'price', value: res[0]['price'] }
    hash_price << { label: 'ce', value: '554' }
    puts hash_price
    send_event('hash_price',  { items: hash_price })
    conn.close
end 
  end
