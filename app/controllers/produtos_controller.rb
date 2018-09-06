class ProdutosController < ApplicationController

    before_action :set_produto, only: [:edit, :update, :destroy]

    def index
        @produtos_por_nome = Produto.order(:nome).limit 5
        @produtos_por_preco = Produto.order :preco
    end

    def new 
        @produto = Produto.new 
        renderiza_new
    end

    def create
        @produto = Produto.new produto_params
        puts "*"*100
        puts @produto

        if @produto.save
            flash[:notice] = "Produto salvo com sucesso"
            redirect_to root_url
        else
            renderiza :new
        end
    end

    def busca
        @nome_a_buscar = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"

    end

    def edit
        renderiza :edit
    end

    def update
        valores = produto_params
        if @produto.update valores
            flash[:notice] = "Produto salvo com sucesso"
            redirect_to root_url
        else
            renderiza :edit
        end
    end

    def destroy
        @produto.destroy
        redirect_to root_url
    end
    
    private

    def renderiza(view)
        @departamentos = Departamento.all
        render view
    end

    def set_produto
        id = params[:id]
        @produto = Produto.find(id)
    end

    def produto_params
        params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
    end

end
