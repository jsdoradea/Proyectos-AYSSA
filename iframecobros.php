<head><title>Cobros</title>
		<link rel="stylesheet" href="<?=base_url()?>css/jquery-ui.css">
		<script src="<?=base_url()?>js/jquery-1.9.1.js"></script>
		<script src="<?=base_url()?>js/jquery-ui.js"></script>
		<script src="<?=base_url()?>js/scriptLib.js"></script>
		
		<script>
			
    			$("#tabs").tabs(tabOpts);

		</script>

	</head>
	<body>
		
		
		<!--<h3 align="center">COBROS</h3>-->
		<!--<div id="container" class="container-fluid">-->
		
				
				<!--<div id="encabezado"></div>
				<div id="tabs">	
					<ul>
						<li>
							<a href="#tabs-1">Cobros</a>
						</li>
						
					</ul>
					<div id="tabs-1">-->
					<?php
						$usuario= $this->session->userdata('usuario');
						$perfil_id=$this->session->userdata('perfil_id');
						$id_empresa= $this->session->userdata('id_empresa');
					?>
						<!--<iframe name="icobros" width="100%" height="700" frameborder="0" scrolling="auto" src="<?=base_url()?>administrador"></iframe>-->
					<iframe name="icobros" width="100%" height="700" frameborder="0" scrolling="auto" src="http://localhost/sgmcc_pre/administrador/sesiones/<?=$usuario?>/<?=$perfil_id?>/<?=$id_empresa?>"></iframe>
				<!--	</div>
				</div>-->
				
						
		<!--</div>-->
		
	</body>
</html>