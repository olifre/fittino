#!/usr/bin/env zsh 



for obs in {0..17}

do
  echo ------ OBS $obs ------

  dir=$job_directory_MERGE/$obs

  if [ ! -d "$dir" ]; then
      mkdir -p $dir
  fi

  cd $dir

  qsub $working_directory/merge.sh $whereIsSetup $obs 

done
