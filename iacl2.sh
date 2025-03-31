#!/bin/bash

echo "Criando diretórios..."
mkdir -p /publico /adm /ven /sec

echo "Criando grupos..."
for grupo in GRP_ADM GRP_VEN GRP_SEC; do
    groupadd $grupo
done

echo "Criando usuários..."
declare -A usuarios=(
    ["carlos"]="GRP_ADM"
    ["maria"]="GRP_ADM"
    ["joao"]="GRP_ADM"
    ["debora"]="GRP_VEN"
    ["sebastiana"]="GRP_VEN"
    ["roberto"]="GRP_VEN"
    ["josefina"]="GRP_SEC"
    ["amanda"]="GRP_SEC"
    ["rogerio"]="GRP_SEC"
)

for usuario in "${!usuarios[@]}"; do
    useradd "$usuario" -m -s /bin/bash -G "${usuarios[$usuario]}"
done

echo "Definindo senhas..."
for usuario in "${!usuarios[@]}"; do
    echo "$usuario:Senha123" | sudo chpasswd
done

echo "Ajustando permissões..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 777 /publico
chmod 770 /adm /ven /sec

echo "Setup concluído! 🚀"

