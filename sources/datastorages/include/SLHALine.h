/* $Id: SimpleDataStorage.h 1509 2013-08-14 13:49:24Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHALine.h                                                       *
*                                                                              *
* Description Stores information of one line of an SLHA file                   *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHALINE_H
#define FITTINO_SLHALINE_H

#include <string>

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \ingroup datastorages
   *  \brief Class for storage of one SLHA file line
   */
  class SLHALine {

    public:
      /*!
       *  Standard constructor.
       */
      SLHALine( const boost::property_tree::ptree& ptree, const ModelBase* model );
      /*!
       *  Standard destructor.
       */
      ~SLHALine();

      std::string   GetBlock() const;
      std::string   GetIndex() const;
      std::string   GetValue() const;
      std::string   GetComment() const; 

    private:
      const double& _value;  
      std::string   _block;
      std::string   _comment;
      std::string   _index;
      
  };

}

#endif // FITTINO_SIMPLEDATASTORAGE_H
