namespace com.cement.commons;

type category : String(1) enum{
    
    raw = 'R';
    intermediate = 'I';
    finished = 'F';
};

// Unit of Measure type (Cement usually deals with MT, KG, or Bags)
type UoM : String(3) enum {
    MetricTon = 'MT';
    Kilogram  = 'KG';
    Bag       = 'BAG';
};


// Standard Status codes for Orders
type OrderStatus : String(1) enum {
    Draft = 'D';
    Open = 'O';
    InProgress = 'P';
    Completed = 'C';
    Cancelled = 'X';
};