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

#ifndef FITTINO_CHECKMATE4CALCULATOR_H
#define FITTINO_CHECKMATE4CALCULATOR_H

#include <string>
#include <vector>
#include <map>

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"
#include "InputFile.h"

namespace Fittino{

   class CheckMATE4Calculator : public CalculatorBase{
        public:
            CheckMATE4Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
            ~CheckMATE4Calculator();
            virtual void CalculatePredictions();

        private:
            bool _fullCLs;
            bool _first;
            double _r;
            double _errorIsDominatedByMonteCarloStatistics;
            double _theModelCouldBeExcludedIfYouProvidedMoreInputEvents;
            double _cls;
            double _excluded;
            std::string _sr;
            std::string _executable;
            std::string _directory;
            InputFile _inputFile;
            std::string _CM_tot_result;
            std::string _CM_r_result;
 //           std::string _inputFile;

            std::string _old_result;
	    std::string _inputfile_test;
        private:
            void ReadResult();
            void ReadrResult();
    };

}
#endif 
