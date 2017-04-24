CREATE TABLE WerrandUser (
  idUser INTEGER  NOT NULL   IDENTITY ,
  FirstName CHAR    ,
  LastName CHAR    ,
  CNIC VARCHAR    ,
  Email VARCHAR    ,
  Contact INTEGER    ,
  Address VARCHAR    ,
  BirthDate DATE    ,
  Pwd VARCHAR(16)      ,
PRIMARY KEY(idUser));
GO




CREATE TABLE ServiceProvider (
  idServiceProvider INTEGER  NOT NULL   IDENTITY ,
  WerrandUser_idUser INTEGER  NOT NULL  ,
  Rating NUMERIC      ,
PRIMARY KEY(idServiceProvider, WerrandUser_idUser)  ,
  FOREIGN KEY(WerrandUser_idUser)
    REFERENCES WerrandUser(idUser));
GO


CREATE INDEX ServiceProvider_FKIndex1 ON ServiceProvider (WerrandUser_idUser);
GO


CREATE INDEX IFK_User_is_SP ON ServiceProvider (WerrandUser_idUser);
GO


CREATE TABLE Customer (
  WerrandUser_idUser INTEGER  NOT NULL  ,
  idCustomer INTEGER  NOT NULL  ,
  Rating NUMERIC      ,
PRIMARY KEY(WerrandUser_idUser, idCustomer)  ,
  FOREIGN KEY(WerrandUser_idUser)
    REFERENCES WerrandUser(idUser));
GO


CREATE INDEX Customer_FKIndex1 ON Customer (WerrandUser_idUser);
GO


CREATE INDEX IFK_User_is_Customer ON Customer (WerrandUser_idUser);
GO


CREATE TABLE Errand (
  idErrand INTEGER  NOT NULL  ,
  Customer_idCustomer INTEGER  NOT NULL  ,
  Customer_WerrandUser_idUser INTEGER  NOT NULL  ,
  ServiceProvider_WerrandUser_idUser INTEGER  NOT NULL  ,
  ServiceProvider_idServiceProvider INTEGER  NOT NULL  ,
  Urgency BIT    ,
  PickupLocation VARCHAR    ,
  DropLocation VARCHAR    ,
  Weight INTEGER    ,
  Date DATETIME    ,
  Description VARCHAR    ,
  ErrandType CHAR      ,
PRIMARY KEY(idErrand, Customer_idCustomer, Customer_WerrandUser_idUser, ServiceProvider_WerrandUser_idUser, ServiceProvider_idServiceProvider)    ,
  FOREIGN KEY(Customer_WerrandUser_idUser, Customer_idCustomer)
    REFERENCES Customer(WerrandUser_idUser, idCustomer),
  FOREIGN KEY(ServiceProvider_idServiceProvider, ServiceProvider_WerrandUser_idUser)
    REFERENCES ServiceProvider(idServiceProvider, WerrandUser_idUser));
GO


CREATE INDEX Customer_has_ServiceProvider_FKIndex1 ON Errand (Customer_WerrandUser_idUser, Customer_idCustomer);
GO
CREATE INDEX Customer_has_ServiceProvider_FKIndex2 ON Errand (ServiceProvider_idServiceProvider, ServiceProvider_WerrandUser_idUser);
GO


CREATE INDEX IFK_Rel_03 ON Errand (Customer_WerrandUser_idUser, Customer_idCustomer);
GO
CREATE INDEX IFK_Rel_04 ON Errand (ServiceProvider_idServiceProvider, ServiceProvider_WerrandUser_idUser);
GO


CREATE TABLE Payment (
  idPayment INTEGER  NOT NULL   IDENTITY ,
  Errand_ServiceProvider_idServiceProvider INTEGER  NOT NULL  ,
  Errand_ServiceProvider_WerrandUser_idUser INTEGER  NOT NULL  ,
  Errand_Customer_WerrandUser_idUser INTEGER  NOT NULL  ,
  Errand_Customer_idCustomer INTEGER  NOT NULL  ,
  Errand_idErrand INTEGER  NOT NULL  ,
  CreditCardConnection VARCHAR      ,
PRIMARY KEY(idPayment, Errand_ServiceProvider_idServiceProvider, Errand_ServiceProvider_WerrandUser_idUser, Errand_Customer_WerrandUser_idUser, Errand_Customer_idCustomer, Errand_idErrand)  ,
  FOREIGN KEY(Errand_idErrand, Errand_Customer_idCustomer, Errand_Customer_WerrandUser_idUser, Errand_ServiceProvider_WerrandUser_idUser, Errand_ServiceProvider_idServiceProvider)
    REFERENCES Errand(idErrand, Customer_idCustomer, Customer_WerrandUser_idUser, ServiceProvider_WerrandUser_idUser, ServiceProvider_idServiceProvider));
GO


CREATE INDEX Payment_FKIndex1 ON Payment (Errand_idErrand, Errand_Customer_idCustomer, Errand_Customer_WerrandUser_idUser, Errand_ServiceProvider_WerrandUser_idUser, Errand_ServiceProvider_idServiceProvider);
GO


CREATE INDEX IFK_Rel_06 ON Payment (Errand_idErrand, Errand_Customer_idCustomer, Errand_Customer_WerrandUser_idUser, Errand_ServiceProvider_WerrandUser_idUser, Errand_ServiceProvider_idServiceProvider);
GO



