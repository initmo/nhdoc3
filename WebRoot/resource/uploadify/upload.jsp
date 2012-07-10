<%@ page language="java" contentType="text/html;charset=GBK" %>
<html>
      <head>
        <title>Uploadify</title>
        <link href="uploadify.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="swfobject.js"></script>
        <script type="text/javascript" src="jquery.uploadify.v2.1.4.js?v=1"></script>
        <script type="text/javascript">
        $(document).ready(function() {
            $("#uploadify").uploadify({
                'uploader'       : 'uploadify.swf',
                'script'         : '<%=request.getContextPath()%>/kc/FileLoadAction.17?method=upload',
                'scriptData'     : {'savePathKey':'vehicleSavePath','sizeList':'5242880'},
                'cancelImg'      : 'cancel.png',
                'folder'         : 'uploads',
                'queueID'        : 'fileQueue',
                'auto'           : false,
                'multi'          : true,
                'simUploadLimit' : 8,
                'buttonText'     : 'BROW',
                'height'        : 30,
                'onSelect' : function(event,queueID,fileObj){},
                'onCancel' : function(event,queueID,fileObj,data){},
                'onComplete':function(event,queueID,fileObj,response,data){

                },
               'onAllComplete'  :function(event,data){}
        });
          });
        </script>
    </head>
    <body>
        <div id="fileQueue"></div>
        <input type="file" name="uploadify" id="uploadify" />
        <p>
        <a href="javascript:jQuery('#uploadify').uploadifyUpload()">开始上传</a>&nbsp;
        <a href="javascript:jQuery('#uploadify').uploadifyClearQueue();">取消所有</a>
        </p>
    </body>
</html>