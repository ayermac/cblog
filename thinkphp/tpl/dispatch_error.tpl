<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>提示</title>

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/nifty.min.css" rel="stylesheet">
    <link href="/static/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<div id="container" class="cls-container">

    <div class="cls-header">
        <div class="cls-brand">
            <a class="box-inline" href="index.html">
                <span class="brand-title">Cblog<span class="text-thin">Admin</span></span>
            </a>
        </div>
    </div>

    <div class="cls-content">
        <h3 class="error-code text-info" style="font-size: 60px;">
            <?php switch ($code) {?>
            <?php case 1:?>
            <i class="fa fa-smile-o fa-lg"></i>
            <p class="success" style="margin-top: 20px;"><?php echo(strip_tags($msg));?></p>
            <?php break;?>
            <?php case 0:?>
            <i class="fa fa-frown-o fa-lg"></i>
            <p class="error" style="margin-top: 20px;"><?php echo(strip_tags($msg));?></p>
            <?php break;?>
            <?php } ?>
        </h3>
        <p class="text-main text-semibold text-lg text-uppercase">
            页面自动 <a id="href" href="<?php echo($url);?>">跳转</a> 等待时间： <b id="wait"><?php echo($wait);?></b>
        </p>

        <hr class="new-section-sm bord-no">
    </div>

</div>
<script type="text/javascript">
    (function(){
        var wait = document.getElementById('wait'),
                href = document.getElementById('href').href;
        var interval = setInterval(function(){
            var time = --wait.innerHTML;
            if(time <= 0) {
                location.href = href;
                clearInterval(interval);
            }
        }, 1000);
    })();
</script>
</body>
</html>

