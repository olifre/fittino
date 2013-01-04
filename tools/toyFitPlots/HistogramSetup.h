class HistogramSetup
{
   public:
               HistogramSetup();
               ~HistogramSetup();
      Bool_t   GetHasData();
      Float_t  GetBestFitPoint();
      Float_t  GetBestFitPointMinusError();
      Float_t  GetBestFitPointPlusError();
      Float_t  GetDataError();
      Float_t  GetDataValue();
      Float_t  GetLeftLimit();
      Float_t  GetRightLimit();
      Int_t    GetDataPrecision();
      Int_t    GetNBins();
      TString  GetAxisLabel();
      TString  GetName();
      TString  GetUnit();
      void     SetAxisLabel(TString axisLabel);
      void     SetBestFitPoint(Float_t bestFitPoint);
      void     SetBestFitPointMinusError(Float_t bestFitPointMinusError);
      void     SetBestFitPointPlusError(Float_t bestFitPointPlusError);
      void     SetDataError(Float_t dataError);
      void     SetDataPrecision(Int_t dataPrecision);
      void     SetDataValue(Float_t dataValue);
      void     SetHasData(Bool_t hasData);
      void     SetLeftLimit(Float_t leftLimit);
      void     SetName(TString name);
      void     SetNBins(Int_t nBins);
      void     SetRightLimit(Float_t rightLimit);
      void     SetUnit(TString unit);

   private:
      Bool_t   _hasData;
      Float_t  _bestFitPoint;
      Float_t  _bestFitPointMinusError;
      Float_t  _bestFitPointPlusError;
      Float_t  _dataValue;
      Float_t  _dataError;
      Float_t  _leftLimit;
      Float_t  _rightLimit;
      Int_t    _dataPrecision;
      Int_t    _nBins;
      TString  _axisLabel;
      TString  _name;
      TString  _unit;
};

HistogramSetup::HistogramSetup()
           : _hasData("kFALSE"),
             _bestFitPoint(1.),
             _bestFitPointMinusError(1.),
             _bestFitPointPlusError(1.),
             _dataValue(0.),
             _dataError(0.),
             _leftLimit(0.),
             _rightLimit(0.),
             _dataPrecision(3),
             _nBins(0),
             _axisLabel("");
             _name(""),
             _unit("")
{
}

HistogramSetup::~HistogramSetup()
{
}

Bool_t HistogramSetup::GetHasData()
{
   return _hasData;
}

Float_t  HistogramSetup::GetBestFitPoint()
{
   return _bestFitPoint;
}

Float_t  HistogramSetup::GetBestFitPointMinusError()
{
   return _bestFitPointMinusError;
}

Float_t  HistogramSetup::GetBestFitPointPlusError()
{
   return _bestFitPointPlusError;
}

Float_t  HistogramSetup::GetDataError()
{
   return _dataError;
}

Float_t HistogramSetup::GetDataValue()
{
   return _dataValue;
}

Float_t HistogramSetup::GetLeftLimit()
{
   return _leftLimit;
}

Float_t HistogramSetup::GetRightLimit()
{
   return _rightLimit;
}

Int_t HistogramSetup::GetDataPrecision()
{
   return _dataPrecision;
}

Int_t HistogramSetup::GetNBins()
{
   return _nBins;
}

TString HistogramSetup::GetAxisLabel()
{
   return _axisLabel;
}

TString HistogramSetup::GetName()
{
   return _name;
}

TString HistogramSetup::GetUnit()
{
   return _unit;
}

void HistogramSetup::SetAxisLabel(TString axisLabel)
{
   _axisLabel = axisLabel;
}

void HistogramSetup::SetBestFitPoint(Float_t bestFitPoint)
{
   _bestFitPoint = bestFitPoint;
}

void  HistogramSetup::SetBestFitPointMinusError(Float_t bestFitPointMinusError)
{
   _bestFitPointMinusError = bestFitPointMinusError;
}

void  HistogramSetup::SetBestFitPointPlusError(Float_t bestFitPointPlusError)
{
   _bestFitPointPlusError = bestFitPointPlusError;
}

void HistogramSetup::SetDataError(Float_t dataError)
{
   _dataError = dataError;
}

void HistogramSetup::SetDataPrecision(Int_t dataPrecision)
{
   _dataPrecision = dataPrecision;
}

void HistogramSetup::SetDataValue(Float_t dataValue)
{
   _dataValue = dataValue;
}

void HistogramSetup::SetHasData(Bool_t hasData)
{
   _hasData = hasData;
}

void HistogramSetup::SetLeftLimit(Float_t leftLimit)
{
   _leftLimit = leftLimit;
}

void HistogramSetup::SetName(TString name)
{
   _name = name;
}

void HistogramSetup::SetNBins(Int_t nBins)
{
   _nBins = nBins;
}

void HistogramSetup::SetRightLimit(Float_t rightLimit)
{
   _rightLimit = rightLimit;
}

void HistogramSetup::SetUnit(TString unit)
{
   _unit = unit;
}
