/* Database created by Adrian Beściak, Dawid Białka - projekt z przedmiotu Podstawy Baz Danych */

/* Tworzenie tabel, warunków integralnościowych, indexów i triggerów */
create table Address
(
	AddressID int identity,

	Country varchar(50) not null,
	Region varchar(50) not null,
	City varchar(50) not null,
	PostalCode varchar(50) not null,
	Street varchar(50) not null,
	Address varchar(50) not null
 CONSTRAINT [PK_AddressID_CINEX] PRIMARY KEY CLUSTERED  (  AddressID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table CDReservation
(
	CDReservationID int identity,
	ClientsClientID int not null
		constraint FKCDReservat850490
			references Clients,
	ConferenceDayID int not null
		constraint FKCDReservat710097
			references ConferenceDay,
	ReservationDate date not null,
	CancellationDate date,
	NumOfParicipants int not null,
	Cancelled bit default 'false' not null,
	PaidAmount numeric(16,2) not null
CONSTRAINT [PK_CDReservation_CINDEX] PRIMARY KEY CLUSTERED  (  CDReservationID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go


create table Clients
(
	ClientID int identity,
	PrivateClientID int
		constraint FKClients521617
			references PrivateClients,
	CompanyID int
		constraint FKClients597535
			references CompanyClients
CONSTRAINT [PK_Clients_CINDEX] PRIMARY KEY CLUSTERED  (  ClientID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go


create table CompanyClients
(
	CompanyID int identity,
	AddressID int not null
		constraint FKCompanyCli848384
			references Address,
	CompanyName varchar(50) not null,
	ContactName varchar(50) not null,
	Phone varchar(50) not null,
	Fax varchar(50) not null,
	Email varchar(50) not null
 CONSTRAINT [PK_CompanyClients_CINDEX] PRIMARY KEY CLUSTERED  (  CompanyID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table Conference
(
	ConferenceID int identity,
	AddressID int not null
		constraint FKConference177987
			references Address,
	Name varchar(50) not null,
	Begin date not null,
	End date not null,
	Cancelled bit constraint DF_Cancelled default 0 not null
 CONSTRAINT [PK_Conference_CINDEX] PRIMARY KEY CLUSTERED  (  ConferenceID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table ConferenceDay
(
	ConferenceDayID int identity,
	ConferenceID int not null
		constraint FKConference184794
			references Conference,
	Date date not null,
	StartTime time not null,
	EndTime time not null,
	MaxAmountOfPeople int not null,
	Cancelled bit default 0 not null,
	FeeForDay numeric(16,2) not null
CONSTRAINT [PK_ConferenceDay_CINDEX] PRIMARY KEY CLUSTERED  (  ConferenceDayID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table ConferenceDayParicipant
(
	ConferenceDayParicipantID int identity,
	CDReservationID int not null
		constraint FKConference489919
			references CDReservation,
	ParicipantID int
		constraint FKConference233755
			references Participant,
	AddDate date not null,
	RemoveDate date
CONSTRAINT [PK_ConferenceDayParicipantID_CINDEX] PRIMARY KEY CLUSTERED  (  ParicipantID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table Participant
(
	ParicipantID int identity,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	Email varchar(50) not null,
	Phone varchar(50) not null,
	StudentCardID varchar(50)
CONSTRAINT [PK_Participant_CINDEX] PRIMARY KEY CLUSTERED  (  ParicipantID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table PrivateClients
(
	PrivateClientID int identity,
	AddressID int not null
		constraint FKPrivateCli914143
			references Address,
	Firstname varchar(50) not null,
	Lastname varchar(50) not null,
	Email varchar(50) not null,
	Phone varchar(50) not null
CONSTRAINT [PK_PrivateClients_CINDEX] PRIMARY KEY CLUSTERED  (  PrivateClientID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table Workshop
(
	WorkshopID int identity,
	ConferenceDayID int not null
		constraint FKWorkshop354008
			references ConferenceDay,
	Name varchar(50) not null,
	StartTime time not null,
	EndTime time not null,
	MaxAmountOfPeople int not null,
	Cancelled bit default 0 not null,
	Fee numeric(16,2) not null
CONSTRAINT [PK_Workshop_CINDEX] PRIMARY KEY CLUSTERED  (  WorkshopID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table WorkshopParticipant
(
	WorkshopParicipantID int identity,
	ConferenceDayParicipantID int not null
		constraint FKWorkshopPa625473
			references ConferenceDayParicipant,
	WorkshopReservationID int not null
		constraint FKWorkshopPa761914
			references WorkshopReservation,
	AddDate date not null,
	RemoveDate date
CONSTRAINT [PK_WorkshopParticipant_CINDEX] PRIMARY KEY CLUSTERED  (  WorkshopParicipantID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go

create table WorkshopReservation
(
	WorkshopReservationID int identity,
	CDReservationID int not null
		constraint FKWorkshopRe912629
			references CDReservation,
	WorkshopID int not null
		constraint FKWorkshopRe425767
			references Workshop,
	ReservationDate date not null,
	CancellationDate date,
	NumOfParicipants int not null,
	PaidAmount numeric(16,2) not null
CONSTRAINT [PK_WorkshopReservation_CINDEX] PRIMARY KEY CLUSTERED  (  WorkshopReservationID ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
go




CREATE NONCLUSTERED INDEX [Address_city_street_city_postalcode_uindex] ON
dbo.Address
        (  City ASC,
         Street ASC,
         PostalCode ASC )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.Address WITH NOCHECK ADD CONSTRAINT [CHK_Address_city] CHECK  ((ltrim([city])<>'')) GO
ALTER TABLE dbo.Address CHECK CONSTRAINT [CHK_Address_city] GO

ALTER TABLE dbo.Address  WITH NOCHECK ADD CONSTRAINT [CHK_Address_street] CHECK  ((ltrim([Street])<>'')) GO
ALTER TABLE dbo.Address CHECK CONSTRAINT [CHK_Address_street] GO

ALTER TABLE dbo.Address  WITH NOCHECK ADD CONSTRAINT [CHK_Address_PostalCode] CHECK ((Address.PostalCode like '[0-9][0-9]-[0-9][0-9][0-9]')) GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [CHK_Address_PostalCode] GO



CREATE NONCLUSTERED INDEX [CompanyClients_addressid_contactname_phone_email_uindex] ON
dbo.CompanyClients
        (  AddressID ASC,
         ContactName ASC,
         Phone ASC
        )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.CompanyClients WITH NOCHECK ADD CONSTRAINT [CHK_CompanyClients_email] CHECK  ((Email like '%_@_%_.__%')) GO
ALTER TABLE dbo.CompanyClients CHECK CONSTRAINT [CHK_CompanyClients_email] GO

ALTER TABLE dbo.CompanyClients  WITH NOCHECK ADD CONSTRAINT [CHK_CompanyClients_companyname] CHECK  ((ltrim(CompanyName)<>'')) GO
ALTER TABLE dbo.CompanyClients CHECK CONSTRAINT [CHK_CompanyClients_companyname] GO

ALTER TABLE dbo.CompanyClients  WITH NOCHECK ADD CONSTRAINT [CHK_CompanyClients_contactname] CHECK  ((ltrim(ContactName)<>'')) GO
ALTER TABLE dbo.CompanyClients CHECK CONSTRAINT [CHK_CompanyClients_contactname] GO

ALTER TABLE dbo.CompanyClients  WITH NOCHECK ADD CONSTRAINT [CHK_CompanyClients_phone] CHECK  ((ltrim(Phone)<>'')) GO
ALTER TABLE dbo.CompanyClients CHECK CONSTRAINT [CHK_CompanyClients_contactname] GO

ALTER TABLE dbo.CompanyClients  WITH NOCHECK ADD CONSTRAINT [CHK_CompanyClients_fax] CHECK  ((ltrim(Fax)<>'')) GO
ALTER TABLE dbo.CompanyClients CHECK CONSTRAINT [CHK_CompanyClients_fax] GO


CREATE TRIGGER dbo.tr_CreateClientRecord2
    ON dbo.CompanyClients
    AFTER INSERT
AS BEGIN
    DECLARE @CompanyID int

    IF @@ROWCOUNT = 0
        RETURN

    IF @@ROWCOUNT = 1
        BEGIN
            SELECT @CompanyID = CompanyID
            FROM INSERTED

            INSERT INTO Clients
                VALUES (NULL, @CompanyID)
        END
    ELSE BEGIN

        DECLARE ClientsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT DISTINCT CompanyID FROM INSERTED

        OPEN ClientsCursor
        FETCH NEXT FROM ClientsCursor INTO @CompanyID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO Clients
                    VALUES (@CompanyID, NULL)
                FETCH NEXT FROM ClientsCursor
                INTO @CompanyID
            END
        CLOSE ClientsCursor
        DEALLOCATE ClientsCursor

    END
END
go

CREATE NONCLUSTERED INDEX [Conference_addressid_name_begin_end__cancelled_uindex] ON
dbo.Conference
        (  AddressID ASC,
         'Begin' ASC,
         End ASC,
         Cancelled ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.Conference WITH NOCHECK ADD CONSTRAINT [CHK_Conference_name] CHECK  ((ltrim(Name)<>'')) GO
ALTER TABLE dbo.Conference CHECK CONSTRAINT [CHK_Conference_name] GO

-- ALTER TABLE dbo.Conference  WITH NOCHECK ADD CONSTRAINT [CHK_Conference_begin] CHECK ((Conference.Begin > GETDATE())) GO
-- ALTER TABLE dbo.Conference CHECK CONSTRAINT [CHK_Conference_begin] GO --do triggera

ALTER TABLE dbo.Conference  WITH NOCHECK ADD CONSTRAINT [CHK_Conference_end] CHECK  (Conference.End > Conference.[Begin]) GO
ALTER TABLE dbo.Conference CHECK CONSTRAINT [CHK_Conference_end] GO



--ALTER TABLE dbo.ConferenceDay  ADD DEFAULT ('9:00:00') FOR StartTime
--ALTER TABLE dbo.ConferenceDay  ADD DEFAULT ('19:00:00') FOR EndTime
ALTER TABLE dbo.ConferenceDay  ADD DEFAULT (0) FOR MaxAmountOfPeople
ALTER TABLE dbo.ConferenceDay  ADD DEFAULT (0) FOR FeeForDay



CREATE NONCLUSTERED INDEX [ConferenceDay_conferenceid_cancelled_uindex] ON
dbo.ConferenceDay
        (  ConferenceID ASC,
         Cancelled ASC
        )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

--ALTER TABLE dbo.ConferenceDay WITH NOCHECK ADD CONSTRAINT [CHK_ConferenceDay_date] CHECK  ((ConferenceDay.Date > GETDATE())) GO
--ALTER TABLE dbo.ConferenceDay CHECK CONSTRAINT [CHK_ConferenceDay_date] GO do triggera

ALTER TABLE dbo.ConferenceDay  WITH NOCHECK ADD CONSTRAINT [CHK_Conference_endtime] CHECK ((ConferenceDay.StartTime < ConferenceDay.EndTime)) GO
ALTER TABLE dbo.ConferenceDay CHECK CONSTRAINT [CHK_Conference_endtime] GO

ALTER TABLE dbo.ConferenceDay  WITH NOCHECK ADD CONSTRAINT [CHK_Conference_maxamountofpeople] CHECK ((ConferenceDay.MaxAmountOfPeople > 0)) GO
ALTER TABLE dbo.ConferenceDay CHECK CONSTRAINT [CHK_Conference_maxamountofpeople] GO

ALTER TABLE dbo.ConferenceDay  WITH NOCHECK ADD CONSTRAINT [CHK_Conference_feeforday] CHECK ((ConferenceDay.FeeForDay > 0)) GO
ALTER TABLE dbo.ConferenceDay CHECK CONSTRAINT [CHK_Conference_feeforday] GO


CREATE NONCLUSTERED INDEX [Participant_phone_studentcardid_uindex] ON
dbo.Participant
        (Phone ASC,
         StudentCardID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.Participant WITH NOCHECK ADD CONSTRAINT [CHK_Participant_firstname] CHECK  ((ltrim(FirstName)<>'')) GO
ALTER TABLE dbo.Participant CHECK CONSTRAINT [CHK_Participant_firstname] GO

ALTER TABLE dbo.Participant WITH NOCHECK ADD CONSTRAINT [CHK_Participant_lastname] CHECK  ((ltrim(LastName)<>'')) GO
ALTER TABLE dbo.Participant CHECK CONSTRAINT [CHK_Participant_lastname] GO

ALTER TABLE dbo.Participant WITH NOCHECK ADD CONSTRAINT [CHK_Participant_phone] CHECK  ((ltrim(Phone)<>'')) GO
ALTER TABLE dbo.Participant CHECK CONSTRAINT [CHK_Participant_phone] GO

ALTER TABLE dbo.Participant WITH NOCHECK ADD CONSTRAINT [CHK_Participant_studentcardid] CHECK  ((ltrim(StudentCardID)<>'')) GO
ALTER TABLE dbo.Participant CHECK CONSTRAINT [CHK_Participant_studentcardid] GO

ALTER TABLE dbo.Participant WITH NOCHECK ADD CONSTRAINT [CHK_Participant_email] CHECK  ((Email like '%_@_%_.__%')) GO
ALTER TABLE dbo.Participant CHECK CONSTRAINT [CHK_Participant_email] GO


CREATE NONCLUSTERED INDEX [PrivateClients_phone_studentcardid_uindex] ON
dbo.PrivateClients
        (AddressID ASC,
         Lastname ASC,
         Phone ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.PrivateClients WITH NOCHECK ADD CONSTRAINT [CHK_PrivateClients_firstname] CHECK  ((ltrim(FirstName)<>'')) GO
ALTER TABLE dbo.PrivateClients CHECK CONSTRAINT [CHK_PrivateClients_firstname] GO

ALTER TABLE dbo.PrivateClients WITH NOCHECK ADD CONSTRAINT [CHK_PrivateClients_lastname] CHECK  ((ltrim(LastName)<>'')) GO
ALTER TABLE dbo.PrivateClients CHECK CONSTRAINT [CHK_PrivateClients_lastname] GO

ALTER TABLE dbo.PrivateClients WITH NOCHECK ADD CONSTRAINT [CHK_PrivateClients_phone] CHECK  ((ltrim(Phone)<>'')) GO
ALTER TABLE dbo.PrivateClients CHECK CONSTRAINT [CHK_PrivateClients_phone] GO

ALTER TABLE dbo.PrivateClients WITH NOCHECK ADD CONSTRAINT [CHK_PrivateClients_email] CHECK  ((Email like '%_@_%_.__%')) GO
ALTER TABLE dbo.PrivateClients CHECK CONSTRAINT [CHK_PrivateClients_email] GO

CREATE TRIGGER dbo.tr_CreateClientRecord1
    ON dbo.PrivateClients
    AFTER INSERT
AS BEGIN
    DECLARE @PrivateClientID int

    IF @@ROWCOUNT = 0
        RETURN

    IF @@ROWCOUNT = 1
        BEGIN
            SELECT @PrivateClientID = PrivateClientID
            FROM INSERTED

            INSERT INTO Clients
                VALUES (@PrivateClientID, NULL)
        END
    ELSE BEGIN

        DECLARE ClientsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT DISTINCT PrivateClientID FROM INSERTED

        OPEN ClientsCursor
        FETCH NEXT FROM ClientsCursor INTO @PrivateClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO Clients
                    VALUES (@PrivateClientID, NULL)
                FETCH NEXT FROM ClientsCursor
                INTO @PrivateClientID
            END
        CLOSE ClientsCursor
        DEALLOCATE ClientsCursor

    END
END
go

go

CREATE NONCLUSTERED INDEX [Clients_privateclientid_companyid_uindex] ON
dbo. Clients
        (PrivateClientID ASC,
         CompanyID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)


CREATE NONCLUSTERED INDEX [CDReservation_clientsclientid_conferencedayid_uindex] ON
dbo.CDReservation
        (ClientsClientID ASC,
         ConferenceDayID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.CDReservation WITH NOCHECK ADD CONSTRAINT [CHK_CDReservation_cancellationdate] CHECK  ((CancellationDate > ReservationDate)) GO
ALTER TABLE dbo.CDReservation CHECK CONSTRAINT [CHK_CDReservation_cancellationdate] GO

ALTER TABLE dbo.CDReservation WITH NOCHECK ADD CONSTRAINT [CHK_CDReservation_paidamount] CHECK  ((PaidAmount >= 0)) GO
ALTER TABLE dbo.CDReservation CHECK CONSTRAINT [CHK_CDReservation_paidamount] GO

ALTER TABLE dbo.CDReservation WITH NOCHECK ADD CONSTRAINT [CHK_CDReservation_numofparticipants] CHECK  ((NumOfParicipants >= 0)) GO
ALTER TABLE dbo.CDReservation CHECK CONSTRAINT [CHK_CDReservation_numofparticipants] GO

go




CREATE NONCLUSTERED INDEX [ConferenceDayParicipant_cdreservationid_participantid_uindex] ON
dbo.ConferenceDayParicipant
        (CDReservationID ASC,
         ParicipantID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
go






CREATE NONCLUSTERED INDEX [Workshop_conferencedayid_cancelled_uindex] ON
dbo.Workshop
        (ConferenceDayID ASC,
         Cancelled ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

--ALTER TABLE dbo.ConferenceDay WITH NOCHECK ADD CONSTRAINT [CHK_ConferenceDay_date] CHECK  ((ConferenceDay.Date > GETDATE())) GO
--ALTER TABLE dbo.ConferenceDay CHECK CONSTRAINT [CHK_ConferenceDay_date] GO do triggera

ALTER TABLE dbo.Workshop  WITH NOCHECK ADD CONSTRAINT [CHK_Workshop_endtime] CHECK ((ConferenceDay.StartTime < ConferenceDay.EndTime)) GO
ALTER TABLE dbo.Workshop CHECK CONSTRAINT [CHK_Workshop_endtime] GO

ALTER TABLE dbo.Workshop  WITH NOCHECK ADD CONSTRAINT [CHK_Workshop_maxamountofpeople] CHECK ((Workshop.MaxAmountOfPeople > 0)) GO
ALTER TABLE dbo.Workshop CHECK CONSTRAINT [CHK_Workshop_maxamountofpeople] GO

ALTER TABLE dbo.Workshop  WITH NOCHECK ADD CONSTRAINT [CHK_Workshop_fee] CHECK ((Workshop.Fee > 0)) GO
ALTER TABLE dbo.Workshop CHECK CONSTRAINT [CHK_Workshop_fee] GO


CREATE NONCLUSTERED INDEX [WorkshopReservation_clientsclientid_conferencedayid_uindex] ON
dbo.WorkshopReservation
        (CDReservationID ASC,
         WorkshopID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

ALTER TABLE dbo.WorkshopReservation WITH NOCHECK ADD CONSTRAINT [CHK_WorkshopReservation_cancellationdate] CHECK  ((CancellationDate > ReservationDate)) GO
ALTER TABLE dbo.WorkshopReservation CHECK CONSTRAINT [CHK_WorkshopReservation_cancellationdate] GO

ALTER TABLE dbo.WorkshopReservation WITH NOCHECK ADD CONSTRAINT [CHK_WorkshopReservation_paidamount] CHECK  ((PaidAmount >= 0)) GO
ALTER TABLE dbo.WorkshopReservation CHECK CONSTRAINT [CHK_WorkshopReservation_paidamount] GO

ALTER TABLE dbo.WorkshopReservation WITH NOCHECK ADD CONSTRAINT [CHK_WorkshopReservation_numofparticipants] CHECK  ((NumOfParicipants >= 0)) GO
ALTER TABLE dbo.WorkshopReservation CHECK CONSTRAINT [CHK_WorkshopReservation_numofparticipants] GO



CREATE NONCLUSTERED INDEX [WorkshopParticipant_clientsclientid_conferencedayid_uindex] ON
dbo.WorkshopParticipant
        (ConferenceDayParicipantID ASC,
         WorkshopReservationID ASC
         )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,
        DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)











/* Procedury i funkcje */

CREATE PROCEDURE dbo.addAddress @Country varchar(50), @Region varchar(50), @City varchar(50), @PostalCode varchar(50),
                @Street varchar(50), @Address varchar(50)
AS
INSERT INTO dbo.Address VALUES (@Country, @Region, @City, @PostalCode, @Street, @Address)
go


CREATE PROCEDURE dbo.addCompanyClient
    @AddressID int,
    @CompanyName varchar(50),
    @ContactName varchar(50),
    @Phone varchar(50),
    @Fax varchar(50),
    @Email varchar(50)
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from Address where AddressID = @AddressID)
        THROW 51000, '@AddresID does not exist in Address', 1

    INSERT INTO CompanyClients VALUES (@AddressID, @CompanyName, @ContactName, @Phone, @Fax, @Email)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addConference @Address int, @Name nvarchar(50), @Begin date, @End date
AS
INSERT INTO dbo.Conference VALUES (@Address, @Name, @Begin, @End, 0);
go



CREATE PROCEDURE dbo.addConferenceDayReservation
    @ConferenceDayID int,
    @ClientID int,
    @ReservationDate date,
    @NumberOfParticipants int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from ConferenceDay where ConferenceDayID = @ConferenceDayID)
        THROW 51000, '@ConferenceDayID does not exist in ConferenceDay', 1

    IF NOT EXISTS(SELECT * from Clients where ClientID = @ClientID)
        THROW 51000, '@ClientID does not exist in Clients', 1

    IF @NumberOfParticipants <= 0
        THROW 51000, '@NumberOfParticipants is not proper value of count of peple', 1

    IF @NumberOfParticipants > (SELECT dbo.freePlacesOnConferenceDay (@ConferenceDayID))
        THROW 51000, '@NumberOfParticipants is higher than available amount of places', 1

    INSERT INTO CDReservation VALUES (@ClientID, @ConferenceDayID, @ReservationDate, null, @NumberOfParticipants, 0, 0)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addDefaultConferenceDay
    @ConferenceID int,
    @Date date

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS ((SELECT * from Conference
        where ConferenceID = @ConferenceID))
        THROW 51000, '@@ConferenceID does not exists', 1

    IF @Date > (SELECT Max(End) FROM Conference WHERE ConferenceID = @ConferenceID)
                OR @Date < (SELECT MIN(Begin) FROM Conference WHERE ConferenceID = @ConferenceID)
        THROW 5100, '@Date is out of Conference', 1


    INSERT INTO ConferenceDay
        VALUES (@ConferenceID, @Date, (TIMEFROMPARTS(9,0,0,0,7)), (TIMEFROMPARTS(19,0,0,0,7)), 0, 0, 0)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addManyDaysConferenceReservation
    @ConferenceID int,
    @ClientID int,
    @FirstDay date,
    @LastDay date,
    @NumberOfParticipants int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from Conference where ConferenceID = @ConferenceID)
        THROW 51000, '@ConferenceID does not exist in Conference', 1

    IF NOT EXISTS(SELECT * from Clients where ClientID = @ClientID)
        THROW 51000, '@ClientID does not exist in Clients', 1

    IF @NumberOfParticipants <= 0
        THROW 51000, '@NumberOfParticipants is not proper value of count of peple', 1

    IF @FirstDay > @LastDay
        THROW 5100, '@FirstDay is later then @LastDay', 1

    DECLARE @ItDay AS DATE = @FirstDay;

    WHILE @ItDay <= @LastDay
        BEGIN
            IF EXISTS(SELECT * from ConferenceDay where Date = @ItDay AND ConferenceID = @ConferenceID)
                INSERT INTO CDReservation VALUES (@ClientID,
                        (SELECT ConferenceDayID from ConferenceDay where Date = @ItDay AND ConferenceID = @ConferenceID),
                                                  @ItDay, null, @NumberOfParticipants, 0, 0)
        END



    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addParticipant
    @FirstName varchar(50),
    @LastName varchar(50),
    @Phone varchar(50),
    @Email varchar(50),
    @StudentCardID varchar(50)


AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;


    INSERT INTO Participant
        VALUES (@FirstName, @LastName, @Phone, @Email, @StudentCardID)


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addParticipantToCDReservation
    @CDReservationID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Email varchar(50),
    @Phone varchar(50),
    @StudentCardID varchar(50)

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from CDReservation where CDReservationID = @CDReservationID)
        THROW 51000, '@CDReservationID does not exist in CDReservation', 1

    IF NOT EXISTS(SELECT * FROM Participant WHERE Email = @Email)
        EXECUTE dbo.addParticipant @FirstName, @LastName, @Phone, @Email, @StudentCardID

    DECLARE @ParticipantID int;

    SELECT @ParticipantID = ParicipantID FROM Participant WHERE Email = @Email

    EXECUTE dbo.connectParticipantToCDReservation @ParticipantID, @CDReservationID

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addParticipantToWorkshopReservation
    @ParticipantID int,
    @WorkshopReservationID int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ParticipantID IS NULL or @WorkshopReservationID IS NULL
        THROW 51000, '@ParticipantID or @WorkshopReservationID is null', 1

    IF NOT EXISTS ((SELECT ParicipantID from Participant
        where ParicipantID = @ParticipantID))
        THROW 51000, '@ParticipantID does not exists', 1

    IF NOT EXISTS ((SELECT WorkshopReservationID from WorkshopReservation
        where WorkshopReservationID = @WorkshopReservationID))
        THROW 51000, '@WorkshopReservationID does not exists', 1

    IF (SELECT NumOfParicipants FROM WorkshopReservation
        where WorkshopReservationID = @WorkshopReservationID)
        =
        (SELECT COUNT(*) from WorkshopReservation WR
            inner join WorkshopParticipant WPw on WR.WorkshopReservationID = WPw.WorkshopReservationID
            where WR.WorkshopReservationID = @WorkshopReservationID
            group by WR.WorkshopReservationID)
        THROW 51000, 'maximum numer of participant for this reservation reached', 1

    DECLARE @ConferenceParticipantID int

    SET @ConferenceParticipantID = (SELECT CDP.ConferenceDayParicipantID from ConferenceDayParicipant CDP
        inner join WorkshopParticipant WP on CDP.ConferenceDayParicipantID = WP.ConferenceDayParicipantID
        inner join WorkshopReservation WR on WP.WorkshopReservationID = WR.WorkshopReservationID
        inner join Participant P on CDP.ParicipantID = P.ParicipantID
        where WR.WorkshopReservationID = @WorkshopReservationID and P.ParicipantID = @ParticipantID)

    DEClARE @WorkshopDate date;
    DECLARE @WorkshopStartTime time;
    DECLARE @WorkshopEndTime time;
    SELECT @WorkshopDate = CD.Date, @WorkshopStartTime = W.StartTime, @WorkshopEndTime = W.EndTime FROM WorkshopReservation WR
                INNER JOIN Workshop W ON W.WorkshopID = WR.WorkshopID
                INNER JOIN ConferenceDay CD ON CD.ConferenceDayID = W.ConferenceDayID
        WHERE WR.WorkshopReservationID = @WorkshopReservationID

    IF dbo.countOfParticipantActivitiesInTimeRange(@ParticipantID, @WorkshopDate, @WorkshopStartTime,
        @WorkshopEndTime) > 0
        BEGIN
            THROW 5100, 'Customer has different workshops in this time', 1
        end

    INSERT INTO WorkshopParticipant
        VALUES (@ConferenceParticipantID, @WorkshopReservationID, GETDATE(), NULL)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addPrivateClient
    @AddressID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Email varchar(50),
    @Phone varchar(50)
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from Address where AddressID = @AddressID)
        THROW 51000, '@AddresID does not exist in Address', 1

    INSERT INTO PrivateClients VALUES (@AddressID, @FirstName, @LastName, @Email, @Phone)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addWorkshop
    @ConferenceDayID int,
    @Name varchar(50),
    @StartTime time,
    @EndTime time,
    @MaxAmountOfPeople int,
    @Fee int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from ConferenceDay where ConferenceDayID = @ConferenceDayID)
        THROW 51000, '@ConferenceDay does not exist in Address', 1

    INSERT INTO Workshop VALUES (@ConferenceDayID, @Name, @StartTime, @EndTime, @MaxAmountOfPeople, 0, @Fee)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.addWorkshopReservation
    @CDReservationID int,
    @WorkshopID int,
    @ReservationDate date,
    @NumberOfParticipants int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS(SELECT * from Workshop where WorkshopID = @WorkshopID)
        THROW 51000, '@WorkshopID does not exist in Workshop', 1

    IF NOT EXISTS(SELECT * from CDReservation where CDReservationID = @CDReservationID)
        THROW 51000, '@CDReservation does not exist in CDReservation', 1

    IF @NumberOfParticipants <= 0
        THROW 51000, '@NumberOfParticipants is not proper value of count of pe0ple', 1

    IF @NumberOfParticipants > dbo.freePlacesOnWorkshop(@WorkshopID)
        THROW 51000, '@NumberOfParticipants is higher than available amount of places', 1



    INSERT INTO WorkshopReservation VALUES (@CDReservationID, @WorkshopID, @ReservationDate, null, @NumberOfParticipants, 0)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelConference
    @ConferenceID int
AS BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceID IS NULL
        THROW 51000, '@ConferenceID is null', 1

    UPDATE Conference
        SET Cancelled = 1
        WHERE ConferenceID = @ConferenceID

    IF @@ROWCOUNT = 0
        THROW 51000, 'no conference with that id', 1

    UPDATE ConferenceDay
        SET Cancelled =1
        WHERE ConferenceID = @ConferenceID


    UPDATE Workshop
        SET Cancelled = 1
        WHERE Workshop.ConferenceDayID in
            (SELECT ConferenceDayID from ConferenceDay
                where ConferenceID = @ConferenceID)

    SELECT ClientsClientID
    INTO ClientsToRemove
    FROM Conference C
        inner join ConferenceDay CD on C.ConferenceID = CD.ConferenceID
        inner join CDReservation CR on CD.ConferenceDayID = CR.ConferenceDayID
    where Date > GETDATE()

    IF @@ROWCOUNT = 0
        THROW 51000, 'no clients signed to that conference', 1

    DECLARE @ClientID int
        DECLARE ClientsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ClientsToRemove

        OPEN ClientsCursor
        FETCH NEXT FROM ClientsCursor INTO @ClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceReservationClient @ClientID, @ConferenceID
                FETCH NEXT FROM ClientsCursor
                INTO @ClientID
            END
        CLOSE ClientsCursor
        DEALLOCATE ClientsCursor



    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelConferenceDayReservationClient
    @ClientID int,
    @ConferenceDayID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceDayID IS NULL or @ClientID IS NULL
        THROW 51000, '@ConferenceID or @ParicipantID is null', 1

    SELECT CDReservationID
    INTO ConferenceDayReservations
    from Clients
        inner join CDReservation CR on Clients.ClientID = CR.ClientsClientID
        inner join ConferenceDay CD on CR.ConferenceDayID = CD.ConferenceDayID
        where CD.ConferenceDayID = @ConferenceDayID and Date > GETDATE() and Clients.ClientID = @ClientID

    IF @@ROWCOUNT = 0
        THROW 51000, '@Client has no reservation on @ConferenceDayID', 1

    UPDATE CDReservation
        SET CancellationDate = GETDATE()
        where CDReservation.CDReservationID in
        (SELECT CDReservationID from ConferenceDayReservations)

    SELECT P.ParicipantID
    INTO ParticipantsFromClient
    from ConferenceDayReservations
        inner join ConferenceDayParicipant CDP on ConferenceDayReservations.CDReservationID = CDP.CDReservationID
        inner join Participant P on CDP.ParicipantID = P.ParicipantID

    IF @@ROWCOUNT = 0
        THROW 51000, '@Client has no participants on @ConferenceDayID', 1

    DECLARE @ParticipantID int
        DECLARE ParticipantsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ParticipantsFromClient

        OPEN ParticipantsCursor
        FETCH NEXT FROM ParticipantsCursor INTO @ParticipantID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceDayReservationParticipant @ParticipantID, @ConferenceDayID
                FETCH NEXT FROM ParticipantsCursor
                INTO @ParticipantID
            END
        CLOSE ParticipantsCursor
        DEALLOCATE ParticipantsCursor

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelConferenceDayReservationParticipant
    @ParticipantID int,
    @ConferenceDayID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceDayID IS NULL or @ParticipantID IS NULL
        THROW 51000, '@ConferenceDayID or @ParicipantID is null', 1


    DECLARE @CDParticipantID int
    SET @CDParticipantID =
        (SELECT ConferenceDayParicipantID from Participant P
            inner join ConferenceDayParicipant CDP on CDP.ParicipantID = P.ParicipantID
            inner join CDReservation CDR on CDR.CDReservationID = CDP.CDReservationID
            inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
            where CDR.ConferenceDayID = @ConferenceDayID and P.ParicipantID = @ParticipantID and Date > GETDATE())

    IF @@ROWCOUNT = 0
        THROW 51000, '@ParticipantID not signed on @ConferenceDayID', 1

    UPDATE ConferenceDayParicipant
        SET RemoveDate = GETDATE()
        where ConferenceDayParicipantID = @CDParticipantID

    UPDATE CDReservation
        SET NumOfParicipants = NumOfParicipants -1
        where CDReservationID in
        (SELECT CDReservation.CDReservationID from CDReservation
            inner join ConferenceDayParicipant CDP on CDReservation.CDReservationID = CDP.CDReservationID
            where ConferenceDayParicipantID = @CDParticipantID)

    SELECT WorkshopID
    INTO Workshops
    FROM ConferenceDay CD
        inner join Workshop W on CD.ConferenceDayID = W.ConferenceDayID

    DECLARE @WorkshopID int
        DECLARE WorkshopsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM Workshops

        OPEN WorkshopsCursor
        FETCH NEXT FROM WorkshopsCursor INTO @WorkshopID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelWorkshopReservationParticipant @ParticipantID, @WorkshopID
                FETCH NEXT FROM WorkshopsCursor
                INTO @WorkshopID
            END
        CLOSE WorkshopsCursor
        DEALLOCATE WorkshopsCursor



    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelConferenceReservationClient
    @ClientID int,
    @ConferenceID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceID IS NULL or @ClientID IS NULL
        THROW 51000, '@ConferenceID or @ParicipantID is null', 1

    SELECT CD.ConferenceDayID
    INTO ConferenceDays
    from ConferenceDay CD
        inner join CDReservation CR on CD.ConferenceDayID = CR.ConferenceDayID
        where ConferenceID = @ConferenceID and Date > GETDATE() and CR.ClientsClientID = @ClientID

    IF @@ROWCOUNT = 0
        THROW 51000, '@Client is not signed on @ConferenceID', 1

    DECLARE @ConferenceDayID int
        DECLARE ConferenceDaysCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ConferenceDays

        OPEN ConferenceDaysCursor
        FETCH NEXT FROM ConferenceDaysCursor INTO @ConferenceDayID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceDayReservationClient @ClientID, @ConferenceDayID
                FETCH NEXT FROM ConferenceDaysCursor
                INTO @ConferenceDayID
            END
        CLOSE ConferenceDaysCursor
        DEALLOCATE ConferenceDaysCursor


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelConferenceReservationParticipant
    @ParticipantID int,
    @ConferenceID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceID IS NULL or @ParticipantID IS NULL
        THROW 51000, '@ConferenceID or @ParicipantID is null', 1

    SELECT CD.ConferenceDayID
    INTO ConferenceDays
    from ConferenceDay CD
        inner join CDReservation CR on CD.ConferenceDayID = CR.ConferenceDayID
        inner join ConferenceDayParicipant CDP on CR.CDReservationID = CDP.CDReservationID
        inner join Participant P on CDP.ParicipantID = P.ParicipantID
        where ConferenceID = @ConferenceID and Date > GETDATE() and P.ParicipantID = @ParticipantID

    IF @@ROWCOUNT = 0
        THROW 51000, '@ParticipantID not signed on @ConferenceID', 1

    DECLARE @ConferenceDayID int
        DECLARE ConferenceDaysCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ConferenceDays

        OPEN ConferenceDaysCursor
        FETCH NEXT FROM ConferenceDaysCursor INTO @ConferenceDayID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceDayReservationParticipant @ParticipantID, @ConferenceDayID
                FETCH NEXT FROM ConferenceDaysCursor
                INTO @ConferenceDayID
            END
        CLOSE ConferenceDaysCursor
        DEALLOCATE ConferenceDaysCursor

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelWorkshop
    @WorkshopID int
AS BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
    BEGIN TRANSACTION;

    IF @WorkshopID IS NULL
        THROW 51000, '@WorkshopID is null', 1

    UPDATE Workshop
        SET Cancelled = 1
        WHERE WorkshopID = @WorkshopID

    IF @@ROWCOUNT = 0
        THROW 51000, 'no workshop with that id', 1

    SELECT ClientsClientID
    INTO ClientsToRemove
    FROM Workshop W
        inner join ConferenceDay CD on W.ConferenceDayID = CD.ConferenceDayID
        inner join CDReservation CR on CD.ConferenceDayID = CR.ConferenceDayID
        where Date > GETDATE() and WorkshopID = @WorkshopID

    IF @@ROWCOUNT = 0
        THROW 51000, 'no clients signed to workshop', 1

    DECLARE @ClientID int
        DECLARE ClientsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ClientsToRemove

        OPEN ClientsCursor
        FETCH NEXT FROM ClientsCursor INTO @ClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelWorkshopReservationClient @ClientID, @WorkshopID
                FETCH NEXT FROM ClientsCursor
                INTO @ClientID
            END
        CLOSE ClientsCursor
        DEALLOCATE ClientsCursor

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelWorkshopReservationClient
    @ClientID int,
    @WorkshopID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @WorkshopID IS NULL or @ClientID IS NULL
        THROW 51000, '@WorkshopID or @ParicipantID is null', 1

    SELECT WorkshopReservationID, WorkshopID
    INTO WorkshopReservations
    from Clients
        inner join CDReservation CR on Clients.ClientID = CR.ClientsClientID
        inner join ConferenceDay CD on CR.ConferenceDayID = CD.ConferenceDayID
        inner join WorkshopReservation WR on CR.CDReservationID = WR.CDReservationID
        where WR.WorkshopID = @WorkshopID and Date > GETDATE() and Clients.ClientID = @ClientID

    IF @@ROWCOUNT = 0
        THROW 51000, '@Client has no reservation on @WorkshopID', 1

    UPDATE WorkshopReservation
        SET CancellationDate = GETDATE()
        where WorkshopReservationID in
        (SELECT WorkshopReservationID from WorkshopReservations)

    SELECT P.ParicipantID
    INTO ParticipantsFromClient
    from WorkshopReservations WR
        inner join WorkshopParticipant WP on WR.WorkshopReservationID = WP.WorkshopReservationID
        inner join ConferenceDayParicipant CDP on WP.ConferenceDayParicipantID = CDP.ConferenceDayParicipantID
        inner join Participant P on CDP.ParicipantID = P.ParicipantID

    IF @@ROWCOUNT = 0
        THROW 51000, '@Client has no participants on @WorkshopID', 1

    DECLARE @ParticipantID int
        DECLARE ParticipantsCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ParticipantsFromClient

        OPEN ParticipantsCursor
        FETCH NEXT FROM ParticipantsCursor INTO @ParticipantID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelWorkshopReservationParticipant @ParticipantID, @WorkshopID
                FETCH NEXT FROM ParticipantsCursor
                INTO @ParticipantID
            END
        CLOSE ParticipantsCursor
        DEALLOCATE ParticipantsCursor

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.cancelWorkshopReservationParticipant
    @ParticipantID int,
    @WorkshopID int
AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @WorkshopID IS NULL or @ParticipantID IS NULL
        THROW 51000, '@WorkshopID or @ParicipantID is null', 1

    SELECT WR.WorkshopReservationID, WP.WorkshopParicipantID
    INTO WorkshopReservations
    from WorkshopReservation WR
        inner join WorkshopParticipant WP on WR.WorkshopReservationID = WP.WorkshopReservationID
        inner join ConferenceDayParicipant CDP on WP.ConferenceDayParicipantID = CDP.ConferenceDayParicipantID
        inner join Participant P on CDP.ParicipantID = P.ParicipantID
        inner join CDReservation CR on WR.CDReservationID = CR.CDReservationID
        inner join ConferenceDay CD on CR.ConferenceDayID = CD.ConferenceDayID
        where WorkshopID = @WorkshopID and Date > GETDATE() and P.ParicipantID = @ParticipantID

    IF @@ROWCOUNT = 0
        THROW 51000, '@ParticipantID not signed on @WorkshopID', 1

    UPDATE WorkshopReservation
        SET NumOfParicipants = NumOfParicipants -1
        where WorkshopReservationID in
        (SELECT WorkshopReservationID FROM WorkshopReservations)

    UPDATE WorkshopParticipant
        SET RemoveDate = GETDATE()
        where WorkshopParicipantID in
        (SELECT WorkshopParicipantID from WorkshopReservations)


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE ClientsNotUpdatedParticipantList

AS
    BEGIN
        SET NOCOUNT ON;

    Select DISTINCT ClientsClientID from CDReservation CDR
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        where CDR.NumOfParicipants > (SELECT COUNT(*) from CDReservation CDRw
        inner join ConferenceDayParicipant CDPw on CDRw.CDReservationID = CDPw.CDReservationID
        where CDRw.CDReservationID = CDR.CDReservationID
        group by CDRw.CDReservationID) and DATEDIFF(day ,CD.Date, GETDATE()) <= 14 and CD.Date > GETDATE()
    end
go



CREATE PROCEDURE dbo.connectParticipantToCDReservation
    @ParticipantID int,
    @CDReservationID int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ParticipantID IS NULL or @CDReservationID IS NULL
        THROW 51000, '@ParticipantID or @ConferenceDayReservationID is null', 1

    IF NOT EXISTS ((SELECT ParicipantID from Participant
        where ParicipantID = @ParticipantID))
        THROW 51000, '@ParticipantID does not exists', 1

    IF NOT EXISTS ((SELECT CDReservationID from CDReservation
        where CDReservationID = @CDReservationID))
        THROW 51000, '@CDReservationID does not exists', 1

    IF (SELECT NumOfParicipants FROM CDReservation
        where CDReservationID = @CDReservationID)
        =
        (SELECT COUNT(*) from CDReservation CDR
            inner join ConferenceDayParicipant CDPw on CDR.CDReservationID = CDPw.CDReservationID
            where CDR.CDReservationID = @CDReservationID
            group by CDR.CDReservationID)
        THROW 51000, 'maximum numer of participants for this reservation reached', 1

    INSERT INTO ConferenceDayParicipant
        VALUES (@CDReservationID, @ParticipantID, GETDATE(), NULL)

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE FUNCTION dbo.countOfParticipantActivitiesInTimeRange (
    @ParticipantID int,
    @Day date,
    @Begin time,
    @End time
)
RETURNS int AS
    BEGIN
        DECLARE @Result int;
        SELECT @Result = COUNT(W.WorkshopID) FROM Participant P INNER JOIN ConferenceDayParicipant CDP on P.ParicipantID = CDP.ParicipantID
                INNER JOIN  WorkshopParticipant WP on CDP.ConferenceDayParicipantID = WP.ConferenceDayParicipantID
                INNER JOIN WorkshopReservation WR on WP.WorkshopReservationID = WR.WorkshopReservationID
                INNER JOIN Workshop W on WR.WorkshopID = W.WorkshopID
                INNER JOIN ConferenceDay CD on W.ConferenceDayID = CD.ConferenceDayID
                WHERE CD.Date = @Day AND P.ParicipantID = @ParticipantID AND (
                        (W.EndTime BETWEEN @Begin AND @End) OR
                        (W.StartTime BETWEEN @Begin AND @End) OR
                        (@Begin > W.StartTime AND @End < W.EndTime)
                    )
        RETURN @Result
    end
go



CREATE FUNCTION finalPrice(
    @BasePrice numeric(16,2),
    @StudentRes int,
    @NormalRes int,
    @ReservationDate Date,
    @StartDate Date)
    RETURNS numeric(16, 2)
    WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS BEGIN

    DECLARE @PriceModifier numeric(3,2)
    DECLARE @DaysDiff int
    DECLARE @StudentDiscount numeric(3,2)

    SET @DaysDiff = DATEDIFF(day, @StartDate, @ReservationDate)
    SET @StudentDiscount = 0.1

    IF @DaysDiff >= 21
        SET @PriceModifier = 0.75
    ELSE IF @DaysDiff >=14
        SET @PriceModifier = 0.85
    ELSE
        SET @PriceModifier = 1.00

    DECLARE @price NUMERIC(20, 6) = @NormalRes * @BasePrice * @PriceModifier +
                                     @StudentRes * @BasePrice * @PriceModifier * @StudentDiscount
    DECLARE @result NUMERIC(16, 2) = CONVERT(NUMERIC(16, 2), ROUND(@price, 2))
    RETURN @result
END
go



CREATE FUNCTION freePlacesOnConferenceDay(
    @ConferenceDayID int)
    RETURNS int
    WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS BEGIN

    DECLARE @MaxAmount int;
    DECLARE @OccupiedPlaces int;

    SELECT @MaxAmount = MaxAmountOfPeople FROM dbo.ConferenceDay WHERE ConferenceDayID = @ConferenceDayID
    SELECT @OccupiedPlaces =  SUM(NumOfParicipants) FROM dbo.CDReservation WHERE ConferenceDayID = @ConferenceDayID

    IF @OccupiedPlaces IS NULL
        RETURN @MaxAmount

    RETURN @MaxAmount - @OccupiedPlaces
END
go



CREATE FUNCTION freePlacesOnWorkshop(
    @WorkshopID int)
    RETURNS int
    WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS BEGIN

    DECLARE @MaxAmount int;
    DECLARE @OccupiedPlaces int;

    SET @MaxAmount = (SELECT MaxAmountOfPeople FROM dbo.Workshop WHERE WorkshopID = @WorkshopID)
    SET @OccupiedPlaces =  (SELECT SUM(NumOfParicipants) FROM dbo.WorkshopReservation WHERE WorkshopID = @WorkshopID GROUP BY WorkshopReservationID)

    IF @OccupiedPlaces IS NULL
        RETURN @MaxAmount

    RETURN @MaxAmount - @OccupiedPlaces
END
go



CREATE PROCEDURE ParticipantsIndentificators
    @ConferenceID int
AS
    BEGIN
         IF @ConferenceID IS NULL
             THROW 51000, '@@ConferenceID is null', 1

    SELECT
        CONVERT(NVARCHAR, C.ConferenceID) + '/' +
        CONVERT(NVARCHAR, CDR.ClientsClientID) + '/' +
        CONVERT(NVARCHAR, P.ParicipantID) AS id
        FROM Conference C
        INNER JOIN ConferenceDay CD on C.ConferenceID = CD.ConferenceID
        INNER JOIN CDReservation CDR on CD.ConferenceDayID = CDR.ConferenceDayID
        INNER JOIN ConferenceDayParicipant CDP on CDR.CDReservationID = CDP.CDReservationID
        INNER JOIN Participant P on CDP.ParicipantID = P.ParicipantID

    end
go



CREATE PROCEDURE dbo.payForConferenceDay
    @ConferenceID int,
    @AmountSend numeric(16, 2)

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;


    IF @ConferenceID IS NULL
        THROW 51000, '@ConferenceID is null', 1

    IF @AmountSend IS NULL OR @AmountSend < 0
        THROW 51000, '@AmountSend is null or less then 0', 1

    UPDATE CDReservation
        SET CDReservation.PaidAmount = CDReservation.PaidAmount + @AmountSend
        where ConferenceDayID = @ConferenceID

    IF @@ROWCOUNT = 0
        THROW 51000, 'no reservation with such id', 1

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.payForWorkshop
    @WorkshopID int,
    @AmountSend numeric(16, 2)

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;


    IF @WorkshopID IS NULL
        THROW 51000, '@WorkshopID is null', 1

    IF @AmountSend IS NULL OR @AmountSend < 0
        THROW 51000, '@AmountSend is null or less then 0', 1

    UPDATE WorkshopReservation
        SET PaidAmount = PaidAmount + @AmountSend
        where WorkshopID = @WorkshopID

    IF @@ROWCOUNT = 0
        THROW 51000, 'no reservation with such id', 1

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.removeConferenceDayReservationSlot
    @ConferenceDayID int,
    @ClientID int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ConferenceDayID IS NULL or @ClientID is NULL
        THROW 51000, '@ConferenceDayID or @ClientID is null', 1

    SELECT NumOfParicipants
    INTO NumOfPart
    from CDReservation CDR
            where CDR.ConferenceDayID = @ConferenceDayID and CDR.ClientsClientID = @ClientID

    IF @@ROWCOUNT = 0
        THROW 51000, '@ClintID has no reservation on @ConferenceDayID', 1

    IF (SELECT * FROM NumOfPart)
        =
       (SELECT COUNT(*) from CDReservation CDR
            inner join ConferenceDayParicipant CDPw on CDR.CDReservationID = CDPw.CDReservationID
            where CDR.ConferenceDayID = @ConferenceDayID and CDR.ClientsClientID = @ClientID
            group by CDR.CDReservationID)
        THROW 51000, 'all slots are filled with signed participants', 1
    ELSE IF (SELECT NumOfParicipants from CDReservation CDR
            where CDR.ConferenceDayID = @ConferenceDayID and CDR.ClientsClientID = @ClientID) = 1
        THROW 51000, 'only 1 slot reserved. You have to cancel the whole reservation', 1
    ELSE
        UPDATE CDReservation
            SET NumOfParicipants = NumOfParicipants -1
            where ConferenceDayID = @ConferenceDayID and ClientsClientID = @ClientID


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.removeReservationsNoParticipantsList

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    Select DISTINCT CD.ConferenceDayID, CDR.ClientsClientID
    INTO ConferenceDayReservationToCanel
    from CDReservation CDR
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        where CDR.NumOfParicipants > (SELECT COUNT(*) from CDReservation CDRw
            inner join ConferenceDayParicipant CDPw on CDRw.CDReservationID = CDPw.CDReservationID
            where CDRw.CDReservationID = CDR.CDReservationID
            group by CDRw.CDReservationID) and DATEDIFF(day ,CD.Date, GETDATE()) <= 7 and CD.Date > GETDATE()

    iF @@ROWCOUNT > 0
    BEGIN
        DECLARE @ConferenceDayID int
        DECLARE @ConfClientID int
        DECLARE ConferenceDaysCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ConferenceDayReservationToCanel

        OPEN ConferenceDaysCursor
        FETCH NEXT FROM ConferenceDaysCursor INTO @ConferenceDayID, @ConfClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceDayReservationClient @ConfClientID, @ConferenceDayID
                FETCH NEXT FROM ConferenceDaysCursor
                INTO @ConferenceDayID, @ConfClientID
            END
        CLOSE ConferenceDaysCursor
        DEALLOCATE ConferenceDaysCursor
    END

    SELECT DISTINCT W.WorkshopID, CDR.ClientsClientID
    INTO WorkshopReservationToCancel
    from WorkshopReservation WR
        inner join CDReservation CDR on WR.CDReservationID = CDR.CDReservationID
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        inner join Workshop W on WR.WorkshopID = W.WorkshopID
        where WR.NumOfParicipants > (SELECT COUNT(*) from WorkshopReservation WRw
            inner join WorkshopParticipant WPw on WRw.WorkshopReservationID = WPw.WorkshopReservationID
            where WRw.WorkshopReservationID = WR.WorkshopReservationID
            group by WRw.WorkshopReservationID) and DATEDIFF(day ,CD.Date, GETDATE()) <= 7 and CD.Date > GETDATE()

    iF @@ROWCOUNT > 0
    BEGIN
        DECLARE @WorkshopID int
        DECLARE @WorkClientID int
        DECLARE WorkshopCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM WorkshopReservationToCancel

        OPEN WorkshopCursor
        FETCH NEXT FROM WorkshopCursor INTO @WorkshopID, @WorkClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelWorkshopReservationClient @WorkClientID, @WorkshopID
                FETCH NEXT FROM WorkshopCursor
                INTO @WorkshopID, @WorkClientID
            END
        CLOSE WorkshopCursor
        DEALLOCATE WorkshopCursor
    END


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.removeReservationsNotPaid

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    Select DISTINCT CD.ConferenceDayID, CDR.ClientsClientID,  CD.Date, CDR.ReservationDate
    INTO ConferenceDayReservationToCancel
    from CDReservation CDR
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        where CDR.PaidAmount <
        (SELECT dbo.finalPrice(CD.FeeForDay,
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRw on CDw.ConferenceDayID = CDRw.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRw.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NOT NULL and CDRw.CDReservationID = CDR.CDReservationID
                group by CDRw.CDReservationID
            ),
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRw on CDw.ConferenceDayID = CDRw.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRw.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NULL and CDRw.CDReservationID = CDR.CDReservationID
                group by CDRw.CDReservationID
            ),
            CD.Date, CDR.ReservationDate) as price) and DATEDIFF(day ,CD.Date, GETDATE()) <= 7 and CD.Date > GETDATE()

    iF @@ROWCOUNT > 0
    BEGIN
        DECLARE @ConferenceDayID int
        DECLARE @ConfClientID int
        DECLARE ConferenceDaysCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM ConferenceDayReservationToCancel

        OPEN ConferenceDaysCursor
        FETCH NEXT FROM ConferenceDaysCursor INTO @ConferenceDayID, @ConfClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelConferenceDayReservationClient @ConfClientID, @ConferenceDayID
                FETCH NEXT FROM ConferenceDaysCursor
                INTO @ConferenceDayID, @ConfClientID
            END
        CLOSE ConferenceDaysCursor
        DEALLOCATE ConferenceDaysCursor
    END


    Select DISTINCT WR.WorkshopID, CDR.ClientsClientID,  CD.Date, CDR.ReservationDate
    INTO WorkshopReservationToCancel
    from WorkshopReservation WR
        inner join CDReservation CDR on WR.CDReservationID = CDR.CDReservationID
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        inner join Workshop W on WR.WorkshopID = W.WorkshopID
        where WR.PaidAmount <
        (SELECT dbo.finalPrice(W.Fee,
            (SELECT COUNT(*) from WorkshopReservation WRw
                inner join WorkshopParticipant WPw on WRw.WorkshopReservationID = WPw.WorkshopReservationID
                inner join ConferenceDayParicipant CDPw on WPw.ConferenceDayParicipantID = CDPw.ConferenceDayParicipantID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NOT NULL and WRw.WorkshopReservationID = WR.WorkshopReservationID
                group by WRw.WorkshopReservationID
            ),
            (SELECT COUNT(*) from WorkshopReservation WRw
                inner join WorkshopParticipant WPw on WRw.WorkshopReservationID = WPw.WorkshopReservationID
                inner join ConferenceDayParicipant CDPw on WPw.ConferenceDayParicipantID = CDPw.ConferenceDayParicipantID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NULL and WRw.WorkshopReservationID = WR.WorkshopReservationID
                group by WRw.WorkshopReservationID
            ),
            CD.Date, WR.ReservationDate) as price) and DATEDIFF(day ,CD.Date, GETDATE()) <= 7 and CD.Date > GETDATE()

    iF @@ROWCOUNT > 0
    BEGIN
        DECLARE @WorkshopID int
        DECLARE @WorkClientID int
        DECLARE WorkshopCursor CURSOR LOCAL FAST_FORWARD
        FOR SELECT * FROM WorkshopReservationToCancel

        OPEN WorkshopCursor
        FETCH NEXT FROM WorkshopCursor INTO @WorkshopID, @WorkClientID
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC cancelWorkshopReservationClient @WorkClientID, @WorkshopID
                FETCH NEXT FROM WorkshopCursor
                INTO @WorkshopID, @WorkClientID
            END
        CLOSE WorkshopCursor
        DEALLOCATE WorkshopCursor
    END

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.removeWorkshopReservationSlot
    @WorkshopID int,
    @ClientID int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @WorkshopID IS NULL or @ClientID IS NULL
        THROW 51000, '@WorkshopID or @ClientID is null', 1

    SELECT WR.NumOfParicipants
    INTO NumOfPart
    from WorkshopReservation WR
        inner join CDReservation CDR on WR.CDReservationID = CDR.CDReservationID
            where WR.WorkshopID = @WorkshopID and CDR.ClientsClientID = @ClientID

    IF @@ROWCOUNT = 0
        THROW 51000, '@ClientID has no reservation on @WorkshopID', 1

    IF (SELECT * FROM NumOfPart)
        =
       (SELECT COUNT(*) from WorkshopReservation WR
            inner join WorkshopParticipant WPw on WR.WorkshopReservationID = WPw.WorkshopReservationID
            where WR.WorkshopID = @WorkshopID
            group by WR.WorkshopReservationID)

        THROW 51000, 'all slots are filled with signed participants', 1

    ELSE IF (SELECT * FROM NumOfPart) = 1
        THROW 51000, 'only 1 slot reserved. You have to cancel the whole reservation', 1
    ELSE
        UPDATE WorkshopReservation
            SET NumOfParicipants = NumOfParicipants -1
            where WorkshopID = @WorkshopID and WorkshopReservationID IN
            (SELECT WR.WorkshopReservationID FROM WorkshopReservation WR
                inner join CDReservation CDR on WR.CDReservationID = CDR.CDReservationID
                where WR.WorkshopID = @WorkshopID and CDR.ClientsClientID = @ClientID)


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.updateCompanyClient
    @CompanyID int,
    @AddressID int,
    @CompanyName varchar(50),
    @ContactName varchar(50),
    @Phone varchar(50),
    @Fax varchar(50),
    @Email varchar(50)


AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @CompanyID IS NULL
        THROW 51000, '@CompanyID is null', 1

    IF @CompanyID not in (SELECT CompanyID from CompanyClients)
        THROW 51000, 'there is no company on @CompanyID', 1

    IF @AddressID IS NOT NULL
        UPDATE CompanyClients
            SET AddressID = @AddressID
            where CompanyID = @CompanyID

    IF @CompanyName IS NOT NULL
        UPDATE CompanyClients
            SET CompanyName = @CompanyName
            where CompanyID = @CompanyID

    IF @ContactName IS NOT NULL
        UPDATE CompanyClients
            SET ContactName = @ContactName
            where CompanyID = @CompanyID

    IF @Phone IS NOT NULL
        UPDATE CompanyClients
            SET Phone = @Phone
            where CompanyID = @CompanyID

    IF @Fax IS NOT NULL
        UPDATE CompanyClients
            SET Fax = @Fax
            where CompanyID = @CompanyID

    IF @Email IS NOT NULL
        UPDATE CompanyClients
            SET Email = @Email
            where CompanyID = @CompanyID


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.updateConferenceDayData
    @ConferenceDayID int,
    @StartTime time,
    @EndTime time,
    @MaxAmounfOfPeople int,
    @FeeForDay int

AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF NOT EXISTS ((SELECT * from ConferenceDay
        where ConferenceDayID = @ConferenceDayID))
        THROW 51000, '@ConferenceDayID does not exists in ConferenceDay', 1

    IF @StartTime > @EndTime
        THROW 5100, 'Conference is starting that day later than it ends', 1

    IF @MaxAmounfOfPeople <= 0
        THROW 5100, 'Number of people is lower than 0', 1

    IF @FeeForDay <= 0
        THROW 5100, 'Fee for this day is lower than 0', 1

    UPDATE ConferenceDay
        SET StartTime = @StartTime, EndTime = @EndTime, MaxAmountOfPeople = @MaxAmounfOfPeople, FeeForDay = @FeeForDay
        WHERE ConferenceDayID = @ConferenceDayID

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.updateParticipant
    @ParticipantID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Phone varchar(50),
    @Email varchar(50),
    @StudentCardID varchar(50)


AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @ParticipantID IS NULL
        THROW 51000, '@PrivateClientID is null', 1

    IF @ParticipantID not in (SELECT ParicipantID from Participant)
        THROW 51000, 'there is no participant on @ParticipantID', 1


    IF @FirstName IS NOT NULL
        UPDATE Participant
            SET Firstname= @FirstName
            where @ParticipantID = @ParticipantID

    IF @LastName IS NOT NULL
        UPDATE Participant
            SET Lastname= @LastName
            where @ParticipantID = @ParticipantID

    IF @Phone IS NOT NULL
        UPDATE Participant
            SET Phone = @Phone
            where @ParticipantID = @ParticipantID

    IF @Email IS NOT NULL
        UPDATE Participant
            SET Email = @Email
            where @ParticipantID = @ParticipantID

     IF @StudentCardID IS NOT NULL
        UPDATE Participant
            SET StudentCardID= @StudentCardID
            where @ParticipantID = @ParticipantID

    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go



CREATE PROCEDURE dbo.updatePrivateClient
    @PrivateClientID int,
    @AddressID int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Phone varchar(50),
    @Email varchar(50)


AS BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    BEGIN TRANSACTION;

    IF @PrivateClientID IS NULL
        THROW 51000, '@PrivateClientID is null', 1

    IF @PrivateClientID not in (SELECT PrivateClientID from PrivateClients)
        THROW 51000, 'there is no client on @PrivateClientID', 1

    IF @AddressID IS NOT NULL
        UPDATE PrivateClients
            SET AddressID= @AddressID
            where PrivateClientID = @PrivateClientID

    IF @FirstName IS NOT NULL
        UPDATE PrivateClients
            SET Firstname= @FirstName
            where PrivateClientID = @PrivateClientID

    IF @LastName IS NOT NULL
        UPDATE PrivateClients
            SET Lastname= @LastName
            where PrivateClientID = @PrivateClientID

    IF @Phone IS NOT NULL
        UPDATE PrivateClients
            SET Phone = @Phone
            where PrivateClientID = @PrivateClientID

    IF @Email IS NOT NULL
        UPDATE PrivateClients
            SET Email = @Email
            where PrivateClientID = @PrivateClientID


    COMMIT TRANSACTION ;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW
    END CATCH
END
go













/* widoki   */



--widoki------------------------------------------

--uczestnicy na dni konferencji

CREATE VIEW ConferenceDayParticipants
AS
    SELECT C.Name, CD.Date, FirstName, Lastname from Conference C
        INNER JOIN ConferenceDay CD on C.ConferenceID = CD.ConferenceID
        INNER JOIN CDReservation CDR on CD.ConferenceDayID = CDR.ConferenceDayID
        INNER JOIN ConferenceDayParicipant CDP on CDR.CDReservationID = CDP.CDReservationID
        INNER JOIN Participant P on CDP.ParicipantID = P.ParicipantID
        WHERE CD.Cancelled = 0 and CDP.RemoveDate IS NULL

CREATE VIEW WorkshopParticipants
AS
    SELECT W.Name, FirstName, LastName from Workshop W
        INNER JOIN WorkshopReservation WR on W.WorkshopID = WR.WorkshopID
        INNER JOIN WorkshopParticipant WP on WR.WorkshopReservationID = WP.WorkshopReservationID
        INNER JOIN ConferenceDayParicipant CDP on WP.ConferenceDayParicipantID = CDP.ConferenceDayParicipantID
        INNER JOIN Participant P on CDP.ParicipantID = P.ParicipantID
        WHERE W.Cancelled = 0 and WP.RemoveDate IS NULL

CREATE VIEW MostActiveClients
AS

    SELECT TOP 15 LastName as Name, 'PrivateClient' as Who, COUNT(*) as NumOfParticipants from PrivateClients
        INNER JOIN Clients C on PrivateClients.PrivateClientID = C.PrivateClientID
        INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
        INNER JOIN ConferenceDayParicipant CDP on CDR.CDReservationID = CDP.CDReservationID
        WHERE CDR.Cancelled = 0 AND CDP.RemoveDate IS NULL
        GROUP BY PrivateClients.LastName
    UNION
    SELECT CompanyName as Name, 'CompanyClient' as Who, COUNT(*) as NumOfParticipants from CompanyClients
        INNER JOIN Clients C on CompanyClients.CompanyID = C.PrivateClientID
        INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
        INNER JOIN ConferenceDayParicipant CDP on CDR.CDReservationID = CDP.CDReservationID
        WHERE CDR.Cancelled = 0 AND CDP.RemoveDate IS NULL
        GROUP BY CompanyName

CREATE VIEW ClientsDebts
AS
    SELECT ConfPrivate.ID, ConfPrivate.Name, ConfPrivate.Who, ConfPrivate.Paid + PrivateWork.Paid as Paid, ConfPrivate.TotalToPay + PrivateWork.TotalToPay as TotalToPay, ConfPrivate.LeftToPay + PrivateWork.LeftToPay as LeftToPay FROM
    (SELECT PrivateClients.PrivateClientID as ID, LastName as Name, 'PrivateClient' as Who, SUM(Paidw) as Paid, SUM(ToPay) as TotalToPay, SUM(Paidw)-SUM(ToPay) as LeftToPay
    from PrivateClients
    INNER JOIN Clients C on PrivateClients.PrivateClientID = C.PrivateClientID
    INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
    INNER JOIN (SELECT CDRw.CDReservationID, CDRw.PaidAmount as Paidw, dbo.finalPrice(CDw.FeeForDay,
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRww on CDw.ConferenceDayID = CDRww.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRww.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NOT NULL and CDRww.CDReservationID = CDRw.CDReservationID
                group by CDRww.CDReservationID
            ),
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRww on CDw.ConferenceDayID = CDRww.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRww.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NULL and CDRww.CDReservationID = CDRw.CDReservationID
                group by CDRww.CDReservationID
            ),
            CDw.Date, CDRw.ReservationDate) as ToPay from ConferenceDay CDw
                INNER JOIN CDReservation CDRw on CDw.ConferenceDayID = CDRw.ConferenceDayID
                WHERE CDw.Date > GETDATE()) as TMP on TMP.CDReservationID = CDR.CDReservationID
            group by PrivateClients.PrivateClientID, Lastname) as ConfPrivate
    INNER JOIN

    (SELECT PrivateClients.PrivateClientID as ID, LastName as Name, 'PrivateClient' as Who, SUM(Paidw) as Paid, SUM(ToPay) as TotalToPay, SUM(Paidw)-SUM(ToPay) as LeftToPay
    from PrivateClients
    INNER JOIN Clients C on PrivateClients.PrivateClientID = C.PrivateClientID
    INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
    INNER JOIN WorkshopReservation WR on CDR.CDReservationID = WR.CDReservationID
    INNER JOIN (SELECT WRw.WorkshopReservationID, WRw.PaidAmount as Paidw, dbo.finalPrice(Ww.Fee,
            (SELECT COUNT(*) from WorkshopReservation WRww
                inner join WorkshopParticipant WPww on WPww.WorkshopReservationID = WRww.WorkshopReservationID
                inner join ConferenceDayParicipant CDPww on WPww.ConferenceDayParicipantID = CDPww.ConferenceDayParicipantID
                inner join Participant Pww on CDPww.ParicipantID = Pww.ParicipantID
                where Pww.StudentCardID IS NOT NULL and WRww.WorkshopReservationID = WRw.CDReservationID
                group by WRww.WorkshopReservationID
            ),
            (SELECT COUNT(*) from WorkshopReservation WRww
                inner join WorkshopParticipant WPww on WPww.WorkshopReservationID = WRww.WorkshopReservationID
                inner join ConferenceDayParicipant CDPww on WPww.ConferenceDayParicipantID = CDPww.ConferenceDayParicipantID
                inner join Participant Pww on CDPww.ParicipantID = Pww.ParicipantID
                where Pww.StudentCardID IS NOT NULL and WRww.WorkshopReservationID = WRw.CDReservationID
                group by WRww.WorkshopReservationID
            ),
            CDw.Date, WRw.ReservationDate) as ToPay from Workshop Ww
                INNER JOIN WorkshopReservation WRw on Ww.WorkshopID = WRw.WorkshopID
                INNER JOIN ConferenceDay CDw on Ww.ConferenceDayID = CDw.ConferenceDayID
                WHERE CDw.Date > GETDATE()) as TMP on TMP.WorkshopReservationID = WR.WorkshopReservationID
                group by PrivateClients.PrivateClientID, Lastname) as PrivateWork on ConfPrivate.ID = PrivateWork.ID

    UNION

    ------------

    SELECT ConfCompany.ID, ConfCompany.Name, ConfCompany.Who, ConfCompany.Paid + ConfCompany.Paid as Paid, ConfCompany.TotalToPay + ConfCompany.TotalToPay as TotalToPay, ConfCompany.LeftToPay + ConfCompany.LeftToPay as LeftToPay FROM
    (SELECT CompanyClients.CompanyID as ID, CompanyName as Name, 'PrivateClient' as Who, SUM(Paidw) as Paid, SUM(ToPay) as TotalToPay, SUM(Paidw)-SUM(ToPay) as LeftToPay
    from CompanyClients
    INNER JOIN Clients C on CompanyClients.CompanyID = C.PrivateClientID
    INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
    INNER JOIN (SELECT CDRw.CDReservationID, CDRw.PaidAmount as Paidw, dbo.finalPrice(CDw.FeeForDay,
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRww on CDw.ConferenceDayID = CDRww.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRww.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NOT NULL and CDRww.CDReservationID = CDRw.CDReservationID
                group by CDRww.CDReservationID
            ),
            (SELECT COUNT(*) from ConferenceDay CDw
                inner join CDReservation CDRww on CDw.ConferenceDayID = CDRww.ConferenceDayID
                inner join ConferenceDayParicipant CDPw on CDRww.CDReservationID = CDPw.CDReservationID
                inner join Participant Pw on CDPw.ParicipantID = Pw.ParicipantID
                where Pw.StudentCardID IS NULL and CDRww.CDReservationID = CDRw.CDReservationID
                group by CDRww.CDReservationID
            ),
            CDw.Date, CDRw.ReservationDate) as ToPay from ConferenceDay CDw
                INNER JOIN CDReservation CDRw on CDw.ConferenceDayID = CDRw.ConferenceDayID
                WHERE CDw.Date > GETDATE()) as TMP on TMP.CDReservationID = CDR.CDReservationID
            group by CompanyClients.CompanyID, CompanyName) as ConfCompany
    INNER JOIN

    (SELECT CompanyClients.CompanyID as ID, CompanyName as Name, 'PrivateClient' as Who, SUM(Paidw) as Paid, SUM(ToPay) as TotalToPay, SUM(Paidw)-SUM(ToPay) as LeftToPay
    from CompanyClients
    INNER JOIN Clients C on CompanyClients.CompanyID = C.PrivateClientID
    INNER JOIN CDReservation CDR on C.ClientID = CDR.ClientsClientID
    INNER JOIN WorkshopReservation WR on CDR.CDReservationID = WR.CDReservationID
    INNER JOIN (SELECT WRw.WorkshopReservationID, WRw.PaidAmount as Paidw, dbo.finalPrice(Ww.Fee,
            (SELECT COUNT(*) from WorkshopReservation WRww
                inner join WorkshopParticipant WPww on WPww.WorkshopReservationID = WRww.WorkshopReservationID
                inner join ConferenceDayParicipant CDPww on WPww.ConferenceDayParicipantID = CDPww.ConferenceDayParicipantID
                inner join Participant Pww on CDPww.ParicipantID = Pww.ParicipantID
                where Pww.StudentCardID IS NOT NULL and WRww.WorkshopReservationID = WRw.CDReservationID
                group by WRww.WorkshopReservationID
            ),
            (SELECT COUNT(*) from WorkshopReservation WRww
                inner join WorkshopParticipant WPww on WPww.WorkshopReservationID = WRww.WorkshopReservationID
                inner join ConferenceDayParicipant CDPww on WPww.ConferenceDayParicipantID = CDPww.ConferenceDayParicipantID
                inner join Participant Pww on CDPww.ParicipantID = Pww.ParicipantID
                where Pww.StudentCardID IS NOT NULL and WRww.WorkshopReservationID = WRw.CDReservationID
                group by WRww.WorkshopReservationID
            ),
            CDw.Date, WRw.ReservationDate) as ToPay from Workshop Ww
                INNER JOIN WorkshopReservation WRw on Ww.WorkshopID = WRw.WorkshopID
                INNER JOIN ConferenceDay CDw on Ww.ConferenceDayID = CDw.ConferenceDayID
                WHERE CDw.Date > GETDATE()) as TMP on TMP.WorkshopReservationID = WR.WorkshopReservationID
                group by CompanyClients.CompanyID, CompanyName) as CompanyWork on ConfCompany.ID = CompanyWork.ID

-------

CREATE VIEW UpcomingConferences
AS
    SELECT Conference.ConferenceID, ConferenceDayID, Name, Date, dbo.freePlacesOnConferenceDay(ConferenceDayID) as freeSlots from Conference
        INNER JOIN ConferenceDay CD on Conference.ConferenceID = CD.ConferenceID
        WHERE CD.Date > GETDATE()

CREATE VIEW UpcomingWorkshops
AS
    SELECT WorkshopID, Workshop.Name, Date, dbo.freePlacesOnWorkshop(Workshop.WorkshopID) as freeSlots from Workshop
        INNER JOIN ConferenceDay CD on Workshop.ConferenceDayID = CD.ConferenceDayID
        WHERE CD.Date > GETDATE()

CREATE PROCEDURE ClientsNotUpdatedParticipantList

AS
    BEGIN
        SET NOCOUNT ON;

    Select DISTINCT ClientsClientID from CDReservation CDR
        inner join ConferenceDay CD on CDR.ConferenceDayID = CD.ConferenceDayID
        where CDR.NumOfParicipants > (SELECT COUNT(*) from CDReservation CDRw
        inner join ConferenceDayParicipant CDPw on CDRw.CDReservationID = CDPw.CDReservationID
        where CDRw.CDReservationID = CDR.CDReservationID
        group by CDRw.CDReservationID) and DATEDIFF(day ,CD.Date, GETDATE()) <= 14 and CD.Date > GETDATE()
    end

CREATE PROCEDURE ParticipantsIndentificators
    @ConferenceID int
AS
    BEGIN
         IF @ConferenceID IS NULL
             THROW 51000, '@@ConferenceID is null', 1

    SELECT
        CONVERT(NVARCHAR, C.ConferenceID) + '/' +
        CONVERT(NVARCHAR, CDR.ClientsClientID) + '/' +
        CONVERT(NVARCHAR, P.ParicipantID) AS id
        FROM Conference C
        INNER JOIN ConferenceDay CD on C.ConferenceID = CD.ConferenceID
        INNER JOIN CDReservation CDR on CD.ConferenceDayID = CDR.ConferenceDayID
        INNER JOIN ConferenceDayParicipant CDP on CDR.CDReservationID = CDP.CDReservationID
        INNER JOIN Participant P on CDP.ParicipantID = P.ParicipantID

    end