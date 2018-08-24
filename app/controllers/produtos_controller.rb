class ProdutosController < ApplicationController

    def index
        @produtos_por_nome = Produto.order(:nome).limit 5
        @produtos_por_preco = Produto.order :preco
    end

    def create
        params[]


    end

end
