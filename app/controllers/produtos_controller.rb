class ProdutosController < ApplicationController

    def index
        @produtos_por_nome = Produto.order(:nome).limit 5
        @produtos_por_preco = Produto.order :preco
    end

    def create
        valores = params.require(:produto).permit :nome, :preco, :descricao
        produto = Produto.create valores
        redirect_to root_url
    end

    def destroy
        id = params[:id]
        Produto.destroy id
        redirect_to root_url
    end

    def busca
        @nome_a_buscar = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"

    end

end
