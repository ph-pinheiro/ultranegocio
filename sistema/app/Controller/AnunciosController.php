<?php
class AnunciosController extends AppController {
	//rss
	public $components = array('RequestHandler');
	public $helpers = array('Text', 'Html');

	public $uses = array("Anuncio", "Imagem");

	public function index(){
		if ($this->RequestHandler->isRss() ) {
	        $anuncios = $this->Anuncio->find(
	            'all',
	            array('limit' => 20, 'order' => 'Anuncio.created DESC')
	        );
	        $this->set(compact('anuncios'));
	    }else{
	        $this->paginate['Anuncio'] = array(
	        	'order' => 'Anuncio.created DESC',
	        	'limit' => 10
	    	);
			$anuncios = $this->paginate();
			$this->set(compact('anuncios'));
		}
	}
	
	public function ver($id){
		$this->set("a", $this->Anuncio->findById($id));
	}

	public function vender_novo() {
		if($this->request->is("post")){
			$this->request->data["Anuncio"]["usuario_id"] = $this->Session->read("usuario.Usuario.id");
			if($this->Anuncio->save($this->data)){
				$this->redirect("/vender/anuncios/fotos/".$this->Anuncio->id);
			}
		}
	}
	public function vender_fotos($id){
		if($this->request->is("post")){
			$dados = array();
			$dados["Imagem"] = $this->data["Anuncio"];
			$dados["Imagem"]["anuncio_id"] = $id;
			if($this->Imagem->save($dados)){
				// copiar foto
				move_uploaded_file($dados["Imagem"]["imagem"]["tmp_name"], WWW_ROOT."img".DS."fotos".DS.$this->Imagem->id.".jpg");
			}
		}
		$this->set("imagens", $this->Imagem->find("all", array("conditions"=>array("Imagem.anuncio_id"=>$id))));
	}
	public function vender_excluirfoto($id, $idA){
		$this->Imagem->delete($id);
		unlink(WWW_ROOT."img".DS."fotos".DS.$id.".jpg");
		$this->redirect("/vender/anuncios/fotos/".$idA);
	}
}