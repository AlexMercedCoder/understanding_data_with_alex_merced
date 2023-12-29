#----------------------------------
# IMPORTS
#----------------------------------
## Import Pyarrow
from pyarrow import flight
from pyarrow.flight import FlightClient
import polars as pl

class DremioConnection:
    
    def __init__(self, token, location):
        self.token = token
        self.location = location
        self.headers = [
    (b"authorization", f"bearer {token}".encode("utf-8"))
    ]
        self.client = FlightClient(location=(location))
        
    def query(self, query, client, headers):
        ## Options for Query
        options = flight.FlightCallOptions(headers=headers)
        
        ## Get ticket to for query execution, used to get results
        flight_info = client.get_flight_info(flight.FlightDescriptor.for_command(query), options)
    
        ## Get Results (Return Value a FlightStreamReader)
        results = client.do_get(flight_info.endpoints[0].ticket, options)
        return results
        
    # Returns a FlightStreamReader
    def toArrow(self, query):
        return self.query(query, self.client, self.headers)
    
    #Returns a DuckDB Relation
    def toPolars(self, querystring):
        streamReader = self.query(querystring, self.client, self.headers)
        table = streamReader.read_all()
        df = pl.from_arrow(table)
        return df