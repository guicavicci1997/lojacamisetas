class ProdutosController < ApplicationController

    def index
        @produtos_por_nome = Produto.order(:nome).limit 5
        @produtos_por_preco = Produto.order :preco
    end

    def new 
        @produto = Produto.new 
        @departamentos = Departamento.all
    end

    def create
        valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :Departamento_id
        @produto = Produto.new valores
        puts "*"*100
        puts @produto

        if @produto.save
            flash[:notice] = "Produto salvo com sucesso"
            redirect_to root_url
        else
            @departamentos = Departamento.all
            render :new    
        end
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

    def edit
        id = params[:id]
        @produto = Ṕroduto.find(id)
        @departamentos = Departamento.all
        render :new
    end

    def update
        id = params[:id]
        @produto = Produto.find(id)
        valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :Departamento_id
        if @produto.update valores
            flash[:notice] = "Produto salvo com sucesso"
            redirect_to root_url
        else
            @departamentos = Departamento.all
            render :new
        end
    end

end
