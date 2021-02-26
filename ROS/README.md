# ROS

## melodic (ubuntu 18)
- install_ros_melodic.sh
  - rosのインストール用sh(ホームディレクトリに配置して実行)  
  `source ~/install_ros_melodic.sh`
- install_cartographer.sh
  - cartographerのインストール用sh(ホームディレクトリに配置して実行)  
  `source ~/install_cartographer.sh`

## bash_aliases_ros
  1. .bash_aliases_rosをホームディレクトリにコピペ
  2. ~/.bashrcに以下を追記(bash_aliasesを追加するコマンドが既にあると思うのでその直下当たりに書くのが美しい)  
  `if [ -f ~/.bash_aliases_ros]; then`  
  `  . ~/.bash_aliases_ros`  
  `fi`
  - 中身
    - catm ... catkin_wsへのcdとcatkin_make
    - bagp ... rosbag play するときによく使うオプション付きの rosbag play 
      - 使用例: bagp hoge.bag
