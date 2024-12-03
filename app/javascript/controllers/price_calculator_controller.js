import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["quantity", "generalTotal"];

  connect() {
    this.updateTotal(); // Initialiser le total lors de la connexion du contrôleur
  }

  updateTotal() {
    let totalGeneral = 0;

    // Parcourir chaque champ de quantité et calculer le total
    this.quantityTargets.forEach((input) => {
      const unitPrice = parseFloat(input.dataset.unitPrice); // Récupérer le prix unitaire
      const quantity = parseInt(input.value) || 0; // Récupérer la quantité entrée, ou 0 si vide
      const totalForOption = unitPrice * quantity; // Calculer le total pour l'option

      // Ajouter au total général
      totalGeneral += totalForOption;
    });

    // Mettre à jour le total général
    this.generalTotalTarget.textContent = totalGeneral.toFixed(2); // Afficher avec 2 décimales
  }
}