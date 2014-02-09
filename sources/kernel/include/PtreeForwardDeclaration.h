/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PtreeForwardDeclaration.h                                        *
*                                                                              *
* Description Forward declaration of boost::property_tree::ptree               *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare >
    class basic_ptree;

    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}
