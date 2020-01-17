using Dates, Printf

const pt_br_meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho",
                     "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
const pt_br_meses_abr = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
const pt_br_dias_da_semana = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"]
const pt_br_dias_da_semana_abr = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"]
Dates.LOCALES["pt-br"] = Dates.DateLocale(pt_br_meses, pt_br_meses_abr, pt_br_dias_da_semana, pt_br_dias_da_semana_abr)

function monta_aulas(inicio, # "yyyy-mm-dd"
                     fim, # "yyyy-mm-dd"
                     dias_da_semana, # [1, 3, 5] -> segunda, quarta, sexta
                     feriados) # Dict("yyyy-mm-dd" => "descricao")
  aula = 1
  for d = Dates.Date(inicio):Dates.Day(1):Dates.Date(fim)
    if dayofweek(d) in dias_da_semana
      print(Dates.format(d, "dd/u (e)", locale="pt-br"))
      s = Dates.format(d, "yyyy-mm-dd")
      if s in keys(feriados)
        println(" " * feriados[s])
      else
        @printf(" Aula %02d\n", aula)
        aula += 1
      end
    end
  end
end

feriados = Dict("2020-04-10" => "Feriado",
                "2020-04-11" => "Recesso",
                "2020-04-20" => "Ponte",
                "2020-04-21" => "Feriado",
                "2020-05-01" => "Feriado",
                "2020-05-02" => "Recesso",
                "2020-05-04" => "JOPT",
                "2020-05-05" => "JOPT",
                "2020-05-06" => "JOPT",
                "2020-06-11" => "Feriado",
                "2020-06-12" => "Ponte"
               )

# Cálculo 2
monta_aulas("2020-03-02", "2020-06-27", [1, 3, 5], feriados)
# Otimização
#monta_aulas("2020-03-02", "2020-06-27", [1, 3], feriados)
