using Final.DAO;
using Final.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Final
{
    public partial class fTableManager : Form
    {
        public fTableManager()
        {
            InitializeComponent();
            LoadTable();
        }

        #region Method

        void LoadTable()
        {
            List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach ( Table item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + item.Status;
                btn.Click += btn_Click;
                btn.Tag = item;
                switch (item.Status)
                {
                    case "Available":
                        btn.BackColor = Color.Aqua;
                        break;
                    default:
                        btn.BackColor = Color.DarkOrange;
                        break;
                }
                flpTable.Controls.Add(btn);

            }
        }
        void ShowBill(int id)
        {
            lsvBill.Items.Clear();
            List<Final.DTO.Mennu> listBillInfo = MenuDAO.Instance.GetListMenuByTable(id);

            foreach (Final.DTO.Mennu item in listBillInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPrice.ToString());

                lsvBill.Items.Add(lsvItem);
            }
        }

        #endregion

        #region Events

        private void btn_Click(object sender, EventArgs e)
        {
            int tableID = ( (sender as Button).Tag as Table).ID;
            ShowBill(tableID);
        }

        private void fTableManager_Load(object sender, EventArgs e)
        {

        }

        private void nmDisCount_ValueChanged(object sender, EventArgs e)
        {

        }

        private void btnCheckOut_Click(object sender, EventArgs e)
        {

        }

        private void btnDiscount_Click(object sender, EventArgs e)
        {

        }

        private void logOutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void userInfoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile();
            f.ShowDialog();
        }

        private void nmFoodCount_ValueChanged(object sender, EventArgs e)
        {

        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAdmin f = new fAdmin();
            f.ShowDialog();
        }
        #endregion
    }
}
