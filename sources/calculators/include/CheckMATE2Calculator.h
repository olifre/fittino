/* $Id: CheckMATE2Calculator.h 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************                            
 *                                                                              *                
 * Project     Fittino - A SUSY Parameter Fitting Package                       *                
 *                                                                              *                    
 * File        CheckMATE2Calculator.h                                           *                  
 * Description: Wrapper class for CheckMATE                                     *          
 * Authors:     Nanette Range                                                   *   
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *                       
 *             modify it under the terms of the GNU General Public License as   *                  
 *             published by the Free Software Foundation; either version 3 of   *                 
 *             the License, or (at your option) any later version.              *                  
 *                                                                              *           
 *******************************************************************************/

#ifndef FITTINO_CHECKMATE2CALCULATOR_H
#define FITTINO_CHECKMATE2CALCULATOR_H

#include <string>
#include <vector>
#include <map>

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"
#include "InputFile.h"

namespace Fittino{

    class CheckMATE2Calculator : public CalculatorBase {

        public:
            CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
            ~CheckMATE2Calculator();
            virtual void CalculatePredictions();

        private:
            bool _fullCLs;
            double _r;
            double _cls;
            std::string _executable;
            std::string _directory;
            InputFile _inputFile;

        private:
            void ReadResult();

    };

}
#endif 
